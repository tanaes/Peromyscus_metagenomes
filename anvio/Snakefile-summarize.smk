from os.path import join, dirname

configfile: "summarize.yaml"
outdir = config['outdir']
contigs_dir = config['contigs_dir']
profile_dir = config['profile_dir']

rule finish:
    input:
        expand(join(outdir, '{group}', '{collection}', 'index.html'),
               group=config['groups'],
               collection=config['collections'])

rule anvi_summarize:
    input:
        contigs=join(contigs_dir, '{group}-contigs.db'),
        profile=join(profile_dir, '{group}', 'PROFILE.db')
    output:
        join(outdir, '{group}', '{collection}', 'index.html')
    run:
        out_dir = dirname(output[0])
        shell("anvi-summarize --just-do-it --fix-sad-tables -c {input.contigs} -p {input.profile} -C {wildcards.collection} -o {out_dir}")
