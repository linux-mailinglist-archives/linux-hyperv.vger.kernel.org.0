Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C159953ABCC
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jun 2022 19:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352075AbiFARZi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 1 Jun 2022 13:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbiFARZh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 1 Jun 2022 13:25:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D115937AB4;
        Wed,  1 Jun 2022 10:25:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 162C4615F9;
        Wed,  1 Jun 2022 17:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301D1C385A5;
        Wed,  1 Jun 2022 17:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654104334;
        bh=jMMe7B3BhgdISh7uct3BKpjV+FPEgE6gFytMtHtHl0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHO+qMWQe5cP8tmgUQqj8fPGjJwS3Otgz+OXIEdGPVJSradD7wwZvicTh/XeTN6xn
         36cftZjh2U4vxTC907inz6H2ofvk+02etbYJZRSA3kWg1Zraq122z9y1G6zY5uAzjM
         9xDC4IBmiXmiVoI5M28u6BmC46gm/t04m9/d3Uk738NKcetPPZ1x+AIx5ihXth0Frb
         Ch9UusaL6Sktiv1EghEBMMueZ59I77EcbHnOJL4/Jl32ORyzuRmi00q7R572WE5XOK
         /zF9VgHnpoTDGhq77ORqvchBakQOe3gxA1stj2MKAJaA3beP0uvbuDT0szSX/KVl+i
         ui6hmrXqhf3Iw==
Date:   Wed, 1 Jun 2022 10:25:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, x86@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org, tboot-devel@lists.sourceforge.net,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 09/15] swiotlb: make the swiotlb_init interface more
 useful
Message-ID: <YpehC7BwBlnuxplF@dev-arch.thelio-3990X>
References: <20220404050559.132378-1-hch@lst.de>
 <20220404050559.132378-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220404050559.132378-10-hch@lst.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Christoph,

On Mon, Apr 04, 2022 at 07:05:53AM +0200, Christoph Hellwig wrote:
> Pass a bool to pass if swiotlb needs to be enabled based on the
> addressing needs and replace the verbose argument with a set of
> flags, including one to force enable bounce buffering.
> 
> Note that this patch removes the possibility to force xen-swiotlb
> use using swiotlb=force on the command line on x86 (arm and arm64
> never supported that), but this interface will be restored shortly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I bisected a performance regression in WSL2 to this change as commit
c6af2aa9ffc9 ("swiotlb: make the swiotlb_init interface more useful") in
mainline (bisect log below). I initially noticed it because accessing the
Windows filesystem through the /mnt/c mount is about 40x slower if I am doing
my math right based on the benchmarks below.

Before:

$ uname -r; and hyperfine "ls -l /mnt/c/Users/natec/Downloads"
5.18.0-rc3-microsoft-standard-WSL2-00008-ga3e230926708
Benchmark 1: ls -l /mnt/c/Users/natec/Downloads
  Time (mean ± σ):     564.5 ms ±  24.1 ms    [User: 2.5 ms, System: 130.3 ms]
  Range (min … max):   510.2 ms … 588.0 ms    10 runs

After

$ uname -r; and hyperfine "ls -l /mnt/c/Users/natec/Downloads"
5.18.0-rc3-microsoft-standard-WSL2-00009-gc6af2aa9ffc9
Benchmark 1: ls -l /mnt/c/Users/natec/Downloads
  Time (mean ± σ):     23.282 s ±  1.220 s    [User: 0.013 s, System: 0.101 s]
  Range (min … max):   21.793 s … 25.317 s    10 runs

I do see 'swiotlb=force' on the cmdline:

$ cat /proc/cmdline
initrd=\initrd.img panic=-1 nr_cpus=8 swiotlb=force earlycon=uart8250,io,0x3f8,115200 console=hvc0 debug pty.legacy_count=0

/mnt/c appears to be a 9p mount, not sure if that is relevant here:

$ mount &| grep /mnt/c
drvfs on /mnt/c type 9p (rw,noatime,dirsync,aname=drvfs;path=C:\;uid=1000;gid=1000;symlinkroot=/mnt/,mmap,access=client,msize=262144,trans=virtio)

If there is any other information I can provide, please let me know.

Cheers,
Nathan

# bad: [700170bf6b4d773e328fa54ebb70ba444007c702] Merge tag 'nfs-for-5.19-1' of git://git.linux-nfs.org/projects/anna/linux-nfs
# good: [4b0986a3613c92f4ec1bdc7f60ec66fea135991f] Linux 5.18
git bisect start '700170bf6b4d773e328fa54ebb70ba444007c702' 'v5.18'
# good: [86c87bea6b42100c67418af690919c44de6ede6e] Merge tag 'devicetree-for-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect good 86c87bea6b42100c67418af690919c44de6ede6e
# bad: [ae862183285cbb2ef9032770d98ffa9becffe9d5] Merge tag 'arm-dt-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad ae862183285cbb2ef9032770d98ffa9becffe9d5
# good: [2518f226c60d8e04d18ba4295500a5b0b8ac7659] Merge tag 'drm-next-2022-05-25' of git://anongit.freedesktop.org/drm/drm
git bisect good 2518f226c60d8e04d18ba4295500a5b0b8ac7659
# bad: [babf0bb978e3c9fce6c4eba6b744c8754fd43d8e] Merge tag 'xfs-5.19-for-linus' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect bad babf0bb978e3c9fce6c4eba6b744c8754fd43d8e
# good: [beed983621fbdfd291e6e3a0cdc4d10517e60af8] ASoC: Intel: avs: Machine board registration
git bisect good beed983621fbdfd291e6e3a0cdc4d10517e60af8
# good: [fbe86daca0ba878b04fa241b85e26e54d17d4229] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good fbe86daca0ba878b04fa241b85e26e54d17d4229
# good: [166afc45ed5523298541fd0297f9ad585cc2708c] Merge tag 'reflink-speedups-5.19_2022-04-28' of git://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into xfs-5.19-for-next
git bisect good 166afc45ed5523298541fd0297f9ad585cc2708c
# bad: [e375780b631a5fc2a61a3b4fa12429255361a31e] Merge tag 'fsnotify_for_v5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
git bisect bad e375780b631a5fc2a61a3b4fa12429255361a31e
# bad: [4a37f3dd9a83186cb88d44808ab35b78375082c9] dma-direct: don't over-decrypt memory
git bisect bad 4a37f3dd9a83186cb88d44808ab35b78375082c9
# bad: [742519538e6b07250c8085bbff4bd358bc03bf16] swiotlb: pass a gfp_mask argument to swiotlb_init_late
git bisect bad 742519538e6b07250c8085bbff4bd358bc03bf16
# good: [9bbe7a7fc126e3d14fefa4b035854aba080926d9] arm/xen: don't check for xen_initial_domain() in xen_create_contiguous_region
git bisect good 9bbe7a7fc126e3d14fefa4b035854aba080926d9
# good: [a3e230926708125205ffd06d3dc2175a8263ae7e] x86: centralize setting SWIOTLB_FORCE when guest memory encryption is enabled
git bisect good a3e230926708125205ffd06d3dc2175a8263ae7e
# bad: [8ba2ed1be90fc210126f68186564707478552c95] swiotlb: add a SWIOTLB_ANY flag to lift the low memory restriction
git bisect bad 8ba2ed1be90fc210126f68186564707478552c95
# bad: [c6af2aa9ffc9763826607bc2664ef3ea4475ed18] swiotlb: make the swiotlb_init interface more useful
git bisect bad c6af2aa9ffc9763826607bc2664ef3ea4475ed18
# first bad commit: [c6af2aa9ffc9763826607bc2664ef3ea4475ed18] swiotlb: make the swiotlb_init interface more useful
