Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6949C020
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jan 2022 01:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiAZA2H (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jan 2022 19:28:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46698 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbiAZA2C (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jan 2022 19:28:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22E7E61488;
        Wed, 26 Jan 2022 00:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99494C340E0;
        Wed, 26 Jan 2022 00:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643156880;
        bh=ksVjsac8pbiJiN9Quz36d8M4Pzg1QwigCdaIkcPJcwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vBj0DhvU5ltRgnu7K8EeAnXUI9PFQwkcs3bFsL4jky4oz4ayDq5IsjRlLyCrZIHaL
         tY4DbmFk3HPotyWwXAV9YiSuEMxgr4HWW9z9GmNwNvYG9E34BToS8gy6UjNzXfVtpV
         Vb+InQ7tzz+WXbnEeZ3fTP35YehN/J/FnuCajoA7Z+TfbFMSFftoSWWmd63h8B/doo
         OzaC52ZAiAMI9lX08p3i/zLDZQFM/opDzWRXmIPPukGmbyA4oFIfkzKwXuvNl17kuL
         D0ZKkYtAs7WQkvCuE+n5p8x2idOWJYI6gSJXpCmrK5pF7fdxACELmU0m5dDOH1KvxR
         F0oMrObYuU1rw==
Date:   Tue, 25 Jan 2022 17:27:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v1 0/9] drivers: hv: dxgkrnl: Driver overview
Message-ID: <YfCVi/TGD9Dnf9CG@dev-arch.archlinux-ax161>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
 <Yd9SQxTznfHGjuDD@archlinux-ax161>
 <bd36b131-be23-6f4d-16cf-a549a6533f34@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd36b131-be23-6f4d-16cf-a549a6533f34@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Iouri,

On Wed, Jan 12, 2022 at 03:39:13PM -0800, Iouri Tarassov wrote:
> 
> On 1/12/2022 2:12 PM, Nathan Chancellor wrote:
> > Hi Iouri,
> > 
> > > We're looking forward additional feedback.
> > 
> > I have been including this patch set into my downstream WSL2 kernel that
> > I build with clang and I noticed an instance of -Wenum-conversion that
> > is still present in this revision:Please consider cleaning this up in a future revision so that clang
> > builds stay clean :)
> > ...
> > I happened to notice there was another function that looks very similar
> > to command_vgpu_to_host_init0(), command_vm_to_host_init0(), which is
> > also unused.  This was hidden because it is marked as "static inline" in
> > a .c file, which should generally be avoided; I would recommend
> > replacing all instances of "static inline" with just "static". The
> > compiler will still inline it if it feels it is worthwhile. Doing this
> > reveals one other unused function, is_empty():
> > 
> > $ sed -i 's/static inline /static /g' drivers/hv/dxgkrnl/*.c
> > 
> > $ make -skj"$(nproc)" LLVM=1 drivers/hv/dxgkrnl/
> > drivers/hv/dxgkrnl/hmgr.c:167:13: warning: unused function 'is_empty' [-Wunused-function]
> > static bool is_empty(struct hmgrtable *table)
> >              ^
> > 1 warning generated.
> > drivers/hv/dxgkrnl/dxgvmbus.c:234:13: warning: unused function 'command_vm_to_host_init0' [-Wunused-function]
> > static void command_vm_to_host_init0(struct dxgkvmb_command_vm_to_host
> >              ^
> > 1 warning generated.
> 
> Thanks a lot! We will get this fixed

In addition to the warnings that I mentioned above, when I apply this
patchset on top of next-20220125, which enables -Warray-bounds, I see
the following warnings with GCC 11.2.1:

drivers/hv/dxgkrnl/ioctl.c: In function ‘init_ioctls’:
drivers/hv/dxgkrnl/ioctl.c:5315:15: warning: array subscript 69 is above array bounds of ‘struct ioctl_desc[69]’ [-Warray-bounds]
 5315 |         ioctls[_IOC_NR(v)].ioctl_callback = callback;   \
      |         ~~~~~~^~~~~~~~~~~~
drivers/hv/dxgkrnl/ioctl.c:5456:9: note: in expansion of macro ‘SET_IOCTL’
 5456 |         SET_IOCTL(/*0x45 */ dxgk_create_sync_file,
      |         ^~~~~~~~~
drivers/hv/dxgkrnl/ioctl.c:34:26: note: while referencing ‘ioctls’
   34 | static struct ioctl_desc ioctls[LX_IO_MAX + 1];
      |                          ^~~~~~
drivers/hv/dxgkrnl/ioctl.c:5316:15: warning: array subscript 69 is above array bounds of ‘struct ioctl_desc[69]’ [-Warray-bounds]
 5316 |         ioctls[_IOC_NR(v)].ioctl = v
      |         ~~~~~~^~~~~~~~~~~~
drivers/hv/dxgkrnl/ioctl.c:5456:9: note: in expansion of macro ‘SET_IOCTL’
 5456 |         SET_IOCTL(/*0x45 */ dxgk_create_sync_file,
      |         ^~~~~~~~~
drivers/hv/dxgkrnl/ioctl.c:34:26: note: while referencing ‘ioctls’
   34 | static struct ioctl_desc ioctls[LX_IO_MAX + 1];
      |                          ^~~~~~
drivers/hv/dxgkrnl/dxgvmbus.c: In function ‘dxgvmb_send_query_alloc_residency’:
drivers/hv/dxgkrnl/dxgvmbus.c:147:16: warning: array subscript ‘struct dxgvmbusmsg[0]’ is partly outside array bounds of ‘struct dxgvmbusmsgres[1]’ [-Warray-bounds]
  147 |         if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
      |             ~~~^~~~~
drivers/hv/dxgkrnl/dxgvmbus.c:1882:31: note: while referencing ‘msg’
 1882 |         struct dxgvmbusmsgres msg = {.hdr = NULL};
      |                               ^~~
drivers/hv/dxgkrnl/dxgvmbus.c: In function ‘dxgvmb_send_open_resource’:
drivers/hv/dxgkrnl/dxgvmbus.c:147:16: warning: array subscript ‘struct dxgvmbusmsg[0]’ is partly outside array bounds of ‘struct dxgvmbusmsgres[1]’ [-Warray-bounds]
  147 |         if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
      |             ~~~^~~~~
drivers/hv/dxgkrnl/dxgvmbus.c:2132:31: note: while referencing ‘msg’
 2132 |         struct dxgvmbusmsgres msg = {.hdr = NULL};
      |                               ^~~
drivers/hv/dxgkrnl/dxgvmbus.c: In function ‘dxgvmb_send_get_stdalloc_data’:
drivers/hv/dxgkrnl/dxgvmbus.c:147:16: warning: array subscript ‘struct dxgvmbusmsg[0]’ is partly outside array bounds of ‘struct dxgvmbusmsgres[1]’ [-Warray-bounds]
  147 |         if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
      |             ~~~^~~~~
drivers/hv/dxgkrnl/dxgvmbus.c:2183:31: note: while referencing ‘msg’
 2183 |         struct dxgvmbusmsgres msg = {.hdr = NULL};
      |                               ^~~
drivers/hv/dxgkrnl/dxgvmbus.c: In function ‘dxgvmb_send_get_allocation_priority’:
drivers/hv/dxgkrnl/dxgvmbus.c:147:16: warning: array subscript ‘struct dxgvmbusmsg[0]’ is partly outside array bounds of ‘struct dxgvmbusmsgres[1]’ [-Warray-bounds]
  147 |         if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
      |             ~~~^~~~~
drivers/hv/dxgkrnl/dxgvmbus.c:3106:31: note: while referencing ‘msg’
 3106 |         struct dxgvmbusmsgres msg = {.hdr = NULL};
      |                               ^~~
drivers/hv/dxgkrnl/dxgvmbus.c: In function ‘dxgvmb_send_reclaim_allocations’:
drivers/hv/dxgkrnl/dxgvmbus.c:147:16: warning: array subscript ‘struct dxgvmbusmsg[0]’ is partly outside array bounds of ‘struct dxgvmbusmsgres[1]’ [-Warray-bounds]
  147 |         if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
      |             ~~~^~~~~
drivers/hv/dxgkrnl/dxgvmbus.c:3298:31: note: while referencing ‘msg’
 3298 |         struct dxgvmbusmsgres msg = {.hdr = NULL};
      |                               ^~~
drivers/hv/dxgkrnl/dxgvmbus.c: In function ‘dxgvmb_send_query_statistics’:
drivers/hv/dxgkrnl/dxgvmbus.c:147:16: warning: array subscript ‘struct dxgvmbusmsg[0]’ is partly outside array bounds of ‘struct dxgvmbusmsgres[1]’ [-Warray-bounds]
  147 |         if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
      |             ~~~^~~~~
drivers/hv/dxgkrnl/dxgvmbus.c:3698:31: note: while referencing ‘msg’
 3698 |         struct dxgvmbusmsgres msg = {.hdr = NULL};
      |                               ^~~

The warning in ioctl.c is resolved with the following diff, which
appears to be a forward port problem, since the WSL2 tree is fine. I
don't see the warning in dxgvmbus.c with clang so I did not look into
it.

Cheers,
Nathan

diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index a7c9fdd95e2e..a32431e3df56 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -1949,6 +1949,6 @@ struct d3dkmt_createsyncfile {
 #define LX_DXCREATESYNCFILE	\
 	_IOWR(0x47, 0x45, struct d3dkmt_createsyncfile)
 
-#define LX_IO_MAX 0x44
+#define LX_IO_MAX 0x45
 
 #endif /* _D3DKMTHK_H */
