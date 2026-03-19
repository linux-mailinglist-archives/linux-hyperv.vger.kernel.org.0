Return-Path: <linux-hyperv+bounces-9543-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODSoMTfzu2lOqgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9543-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 13:59:35 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF9F2CB931
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 13:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DB9D30E27E1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D543D34A4;
	Thu, 19 Mar 2026 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udm/5szm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B7F3D3492;
	Thu, 19 Mar 2026 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924755; cv=none; b=jOIU9yTWT+GnpZT92iE3svYT1zk+AwO3exk7ah89EFBDoZM2AmBdMVxE0Ed+2ccHVV5U97RIEzUWjIiQTwWngk9fG/zhCjmE6V5TtjCaK7PXT5KE0z4Ltbby3F4iNTKs6CHjaUgXAQREf2owWuQ4XOAVrJkCJib+T1AQRUJajeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924755; c=relaxed/simple;
	bh=jA7diFAaatzjClu0BNNjaXH84miUw/aL+tXzTcfiSyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+v+sUPhqp7WzQlVSkngWBHURtLdXi+iSALx8mCKy+c38B1z9U6vZK3MafCmB13WXSmzwfoHZhqTjhxtzf+OeVgYhkfOlwUVO/odjG0rVVJ3jBEY5AgvFs1KrcXhrmWtyGQNhCGXnYa1c55676688xZ3/wJE6yExDTQZqgCLYMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udm/5szm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9282C19424;
	Thu, 19 Mar 2026 12:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773924755;
	bh=jA7diFAaatzjClu0BNNjaXH84miUw/aL+tXzTcfiSyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Udm/5szmcmrn1FQPUv6e/j0SN6gP++q+sDVLk95f5h2PMysLxA/Z+vmQxnocUccUn
	 NuBv89GwjGw+atxJn1J0so9qkU5Fz40p+PTENxR41hcO8d78y7WoL7d68u7RJwiVoU
	 24b8F9r9Rglgs2jG81B2Ku5fqywDVKhnmPJe34SHQaQbe0jVM5wnV7X8Yl87k20mNN
	 uLVYl3OTVyKbPcX2UWMxSpOwWjfeL17ZUhqEmwTrU9V9I6dAEZqrK0WhNYjr1Zk1rv
	 FL2a3cllmUIkPZSTj7CNTbJNtleLxEuRoC6olnUM1WEiLl3YJslQyYkYq6xD3FW/z0
	 rvKJyE92if+Dg==
Date: Thu, 19 Mar 2026 12:52:22 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Clemens Ladisch <clemens@ladisch.de>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "K . Y . Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Bodo Stroesser <bostroesser@gmail.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-mtd@lists.infradead.org, linux-staging@lists.linux.dev, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v2 12/16] mm: allow handling of stacked mmap_prepare
 hooks in more drivers
Message-ID: <caf19e7e-e8dc-4409-8655-f734279b0c45@lucifer.local>
References: <72750af6906fd96fb6f18e83ac3e694cf357a2c1.1773695307.git.ljs@kernel.org>
 <20260318210845.2591228-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318210845.2591228-1-joshua.hahnjy@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9543-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[44];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,ladisch.de,arndb.de,linuxfoundation.org,microsoft.com,kernel.org,linux.intel.com,gmail.com,foss.st.com,bootlin.com,nod.at,ti.com,oracle.com,redhat.com,auristor.com,zeniv.linux.org.uk,suse.cz,google.com,suse.com,suse.de,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,lists.linux.dev,kvack.org,arm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lucifer.local:mid]
X-Rspamd-Queue-Id: 2BF9F2CB931
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 02:08:45PM -0700, Joshua Hahn wrote:
> On Mon, 16 Mar 2026 21:12:08 +0000 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org> wrote:
>
> > While the conversion of mmap hooks to mmap_prepare is underway, we wil
> > encounter situations where mmap hooks need to invoke nested mmap_prepare
> > hooks.
> >
> > The nesting of mmap hooks is termed 'stacking'.  In order to flexibly
> > facilitate the conversion of custom mmap hooks in drivers which stack, we
> > must split up the existing compat_vma_mapped() function into two separate
> > functions:
> >
> > * compat_set_desc_from_vma() - This allows the setting of a vm_area_desc
> >   object's fields to the relevant fields of a VMA.
>
> Hello Lorenzo, I hope you are doing well!
>
> Thank you for this patch. I was developing on top of mm-new today and had
> an error that I think was caused by this patch. I want to preface this by
> saying that I am not at all familiar with this area of the code, so please
> do forgive me if I've misinterpreted the crash and mistakenly pointed
> at this commit : -)
>
> Here is the crash:
>
> [    1.083795] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> [    1.083883] BUG: unable to handle page fault for address: ffa00000048efbb8
> [    1.083957] #PF: supervisor instruction fetch in kernel mode
> [    1.084030] #PF: error_code(0x0011) - permissions violation
> [    1.084086] PGD 100000067 P4D 10035f067 PUD 100364067 PMD 441ed9067 PTE 80000004466a3163
> [    1.084162] Oops: Oops: 0011 [#1] SMP
> [    1.084218] CPU: 0 UID: 0 PID: 305 Comm: mkdir Tainted: G        W   E       7.0.0-rc4-virtme-00442-ge53de5a0302f-dirty #85 PREEMPTLAZY
>
> As you can see, it's on a QEMU instance. I don't think this makes a difference
> in the crash, though.
>
> [    1.084321] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
> [    1.084369] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-5.el9 11/05/2023
> [    1.084450] RIP: 0010:0xffa00000048efbb8
> [    1.084489] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <40> 12 0e 00 01 00 11 ff d0 fa 8e 04 00 00 a0 ff 80 33 51 02 01 00
> [    1.084642] RSP: 0018:ffa00000048ef998 EFLAGS: 00010286
> [    1.084692] RAX: ffa00000048efbb8 RBX: ff11000102512cc0 RCX: 000000000000000d
> [    1.084766] RDX: ffffffffa06247d0 RSI: ffa00000048efa18 RDI: ff11000102512cc0
> [    1.084826] RBP: ffa00000048ef9c8 R08: 0000000000000000 R09: 0000000000000007
> [    1.084889] R10: ff110001047d1f08 R11: 00007effdc3d0fff R12: ff110001047d3b00
> [    1.084954] R13: ff11000446cae600 R14: ff110001024efe00 R15: ff11000102510a80
> [    1.085021] FS:  0000000000000000(0000) GS:ff110004aae72000(0000) knlGS:0000000000000000
> [    1.085083] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.085136] CR2: ffa00000048efbb8 CR3: 0000000102667001 CR4: 0000000000771ef0
> [    1.085201] PKRU: 55555554
> [    1.085228] Call Trace:
> [    1.085248]  <TASK>
> [    1.085274]  ? __compat_vma_mmap+0x8e/0x130
> [    1.085318]  ? compat_vma_mmap+0x76/0x80
> [    1.085354]  ? mas_alloc_nodes+0xb2/0x110
> [    1.085390]  ? backing_file_mmap+0xc3/0xf0
> [    1.085426]  ? ovl_mmap+0x41/0x50
> [    1.085463]  ? ovl_mmap+0x50/0x50
> [    1.085499]  ? __mmap_region+0x7e8/0x1100
> [    1.085539]  ? do_mmap+0x49f/0x5e0
> [    1.085573]  ? vm_mmap_pgoff+0xef/0x1e0
> [    1.085609]  ? ksys_mmap_pgoff+0x15c/0x1f0
> [    1.085647]  ? do_syscall_64+0xab/0x980
> [    1.085684]  ? entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [    1.085730]  </TASK>
> [    1.085770] Modules linked in: virtio_mmio(E) 9pnet_virtio(E) 9p(E) 9pnet(E) netfs(E)
> [    1.085838] CR2: ffa00000048efbb8
> [    1.085874] ---[ end trace 0000000000000000 ]---
> [    1.085875] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> [    1.085918] RIP: 0010:0xffa00000048efbb8
> [    1.085921] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <40> 12 0e 00 01 00 11 ff d0 fa 8e 04 00 00 a0 ff 80 33 51 02 01 00
> [    1.085988] BUG: unable to handle page fault for address: ffa00000048f7bb8
> [    1.086026] RSP: 0018:ffa00000048ef998 EFLAGS: 00010286
> [    1.086166] #PF: supervisor instruction fetch in kernel mode
> [    1.086221]
> [    1.086267] #PF: error_code(0x0011) - permissions violation
> [    1.086321] RAX: ffa00000048efbb8 RBX: ff11000102512cc0 RCX: 000000000000000d
> [    1.086348] PGD 100000067
> [    1.086394] RDX: ffffffffa06247d0 RSI: ffa00000048efa18 RDI: ff11000102512cc0
> [    1.086459] P4D 10035f067
> [    1.086486] RBP: ffa00000048ef9c8 R08: 0000000000000000 R09: 0000000000000007
> [    1.086550] PUD 100364067
> [    1.086577] R10: ff110001047d1f08 R11: 00007effdc3d0fff R12: ff110001047d3b00
> [    1.086641] PMD 441ed9067
> [    1.086668] R13: ff11000446cae600 R14: ff110001024efe00 R15: ff11000102510a80
> [    1.086731] PTE 80000004433d3163
> [    1.086764] FS:  0000000000000000(0000) GS:ff110004aae72000(0000) knlGS:0000000000000000
> [    1.086829]
> [    1.086868] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.086931] Oops: Oops: 0011 [#2] SMP
> [    1.086958] CR2: ffa00000048efbb8 CR3: 0000000102667001 CR4: 0000000000771ef0
> [    1.087015] CPU: 29 UID: 0 PID: 306 Comm: mount Tainted: G      D W   E       7.0.0-rc4-virtme-00442-ge53de5a0302f-dirty #85 PREEMPTLAZY
> [    1.087050] PKRU: 55555554
> [    1.087115] Tainted: [D]=DIE, [W]=WARN, [E]=UNSIGNED_MODULE
> [    1.087207] Kernel panic - not syncing: Fatal exception
> [    2.158392] Shutting down cpus with NMI
> [    2.158629] Kernel Offset: disabled
> [    2.158668] ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> It crashes at compat_vma_mmap, and here is what I think could be the
> potential crash path:
>
> - compat_vma_mmap() creates struct vm_area_desc desc;
>   - compat_set_desc_from_vma Doesn't initialize the struct, but instead
>     modifies independent fields. I think this is where the behavior
>     diverges, since before we would use the C initializer and uninitialized

Ah yeah you're right I'll fix that up!

>     variables would be set to 0 (including ommitted ones, like
>     action.success_hook or action.error_hook). But action.type = MMAP_NOTHING
>   - desc.action.success_hook remains uninitialized in vfs_mmap_prepare
>   - mmap_action_complete()
>     - Here, We've set action.type to be MMAP_NOTHING, so we have err = 0
>     - mmap_action_finish(action, vma, 0)
>       - And here, since err == 0, we check action->success_hook (which has
>         garbage, therefore it's nonzero) and call action->success_hook(vma)
>
> And I think action->success_hook(vma) where success_hook is uninitialized
> stack garbage gets me to where I am.
>
> Again, I'm not too familiar with this area of the kernel, this is just
> based on the quick digging that I did. And aplogies again if I'm missing
> something ; -) I do think that the uninitialized members could be a problem
> though.
>
> Thank you, I hope you have a great day Lorenzo!
> Joshua

Thanks for the report and analysis, much appreciated, hope you have a great
day too :)

Cheers, Lorenzo

