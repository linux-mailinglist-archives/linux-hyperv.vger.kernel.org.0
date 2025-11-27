Return-Path: <linux-hyperv+bounces-7894-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 210BCC8F3F2
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 16:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F2A54ED388
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248AD28314A;
	Thu, 27 Nov 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzWzX9Kz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p2nfn/Yu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A53126A6
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Nov 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256665; cv=none; b=gLZxxyyxsPirtnPEQFo9jskhuXhuf/jgUUkeH0Cr3vxUDb93b6/vxmRVcc8QtE5lXHm/6kE87zFpkRf2LW6IpyucNJiBqwnh2f8LxEhFM+Yn2+mohSMpbrbAVLtzrhe5+jbd2kK4mcW5hAhXTakRiSb/2gfo6SIEVHfRL2zlkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256665; c=relaxed/simple;
	bh=Eu9nhkA610Zkoei5vnzKgM1UCmVGe/fzcjwN9lzIg5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G23Kpekb7dh9TSS5TecbalwuPTfXJcFAXJR5j88Vq/Hf3hpWKC8vHWmrj7CsN4BXySzVeAvxeaBEDkO1IEkob/q+Q4DdU5XQ9rMy0Y2zYHMLihGSjUcp88oCyKit9q1jNeLoXMp9B6XBBGUC07Q9dqYtDND8yIUudDnB/tRAxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzWzX9Kz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p2nfn/Yu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764256662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XahVD9vm950vULRmoTKsf8U8y6l5rrL/cOJk/JVP1ro=;
	b=FzWzX9Kzhdnt8uubOxwavfi5vilnG7OusY3FD8YpDvQAcO/SsSdmCVNXd8Qufk5KYXKafr
	vU1XboRPSdoE2lUAzSJ9eGIibwadB/jFeVYIePKdDytQWfAn92kuMH5tyaayAWPWRJg5io
	jFq9NkKxU1TNiU9StIHlGMN8SYXIsRQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-wwiFSNHOP5SdV9Mcp5QN3w-1; Thu, 27 Nov 2025 10:17:40 -0500
X-MC-Unique: wwiFSNHOP5SdV9Mcp5QN3w-1
X-Mimecast-MFC-AGG-ID: wwiFSNHOP5SdV9Mcp5QN3w_1764256657
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42e1e1ca008so398568f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 27 Nov 2025 07:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764256657; x=1764861457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XahVD9vm950vULRmoTKsf8U8y6l5rrL/cOJk/JVP1ro=;
        b=p2nfn/YuuoqHv+WpF7zyfo7G27XNxNvAf0VHZ+/2RZWafNmbAOpY4u7tj7KtjpgRWb
         FvyyDeZotzBk/qQdMIkg7QwQ10h9p961cDNI0SIcjg00xE7aVii6gJyCZZLw+cmrrZB5
         xPrYblKgnBttozF8pyoj+04PF/yyyfPklO9kx/FMRJpzuA2jxZb4HSw8/GUS7++ayep5
         u9EYhcPTcZUlo2cFyIcWVr2KqWAxIkRPfYR91I54DW5XWHaxJroK/13tuqN4LeC2ykbz
         gdbQgEc4wHZBWvIcZFttXPoNf/JLGXmB2vZ45WHutOX+IaK4K3es1JIu3pFUtLwn9ByC
         zkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764256657; x=1764861457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XahVD9vm950vULRmoTKsf8U8y6l5rrL/cOJk/JVP1ro=;
        b=Y8dSb6mBwPTymx23OMSpK0sPiyTVh/++vat1BQKdMXeNgxGaM0qdiTHNcG4vbC/sbz
         ddmvbAlmM1wVZRRj8sw/+ItsrGHR5IEN8fyiNXoldUq8YtU1a5d3qz9LyQqLD1OlGC24
         tkxjg9RV3WNbi2qd3rLEgON5TMIJkdQDbyQQ2FPa0B4BA9jUxfFuHBcatiOa6s7dKLgY
         MbBVPZwC50RY92PDCdThBIGYwHJ50Wd3RXITTwdeS/5MtluZ8l22Ywu1lo0ClwY/BIEr
         LdQyrY7N8t3rzpWntGZlpetXo8YoE1eZVlDA1ORJShujPHKRbjPUe8WKDLA/aL6TYXS0
         w9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbkxai0uSHGkIgMXAbbh5PeXW+WI/Bz2wdBa77ZWwvQ9T8Sbq4EWHZ248JD7TToRRA6L3l/M1v3M8uo0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0F7WzKCQ8I8CVXSrim52q+XtgOnlSfupjLuBeu83Xac5V7EUc
	1JF9aQZfi3Hztjm353+Lwe/0tjzKEDIICI/9iVmjqJu/5UJHQht5VDHr0YAv1RB/FX6ae5ireNN
	7alh8ips5Z3M+O0iXuezGIBh6+2G28keuRf4JIOuMpFoB64vzv1V+vctUC7L1lQfGpQ==
X-Gm-Gg: ASbGncsrcpezUu8yO40F5a8rURbqBEG9xphOJ4I+hNozBJJ3XlU8v2FXR4xc9J2FBi4
	mZ7kn1CU8b90Mt+KDWmpK1bLu2t09cG2pEhLOkCPwT4WPO9csrsUxsIL5wBVAdFm2KRBNW2bOVC
	txD9Z+nS27FhiCAJ5tat9qAggqr1UkVmgV0GfGj5KM3Tk6ZCUAFo0WSp+KjRrYiMEMG5pQ11qtQ
	0jegl3yg/8xWCN2qeDrw0IRONxvgCZ9hfD/ManhvC/dhK2nc6bDv4Jq9aBJeDBMGPptQzWy405K
	wI53zuuKBq18dwLb+tfFXGX0XxrgiHxc7QdXjYTy3TFmDBp4/14lKwFut9j8E4GWSOyzDoH+DCM
	bkzcvPcISIbn3JkIjDVQ64ZB74VpWA4WykE5kQ2vnACYNebYVI4ZLyvxRJfSTsA==
X-Received: by 2002:a05:6000:4026:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-42cc125247bmr30431025f8f.0.1764256657281;
        Thu, 27 Nov 2025 07:17:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ+jdLavUsk4iLz9JRe9mjjqfPbPHxCozjJIA1dySmt1DAyfbZqFFxQifjK8Bc7KbrtWVwHw==
X-Received: by 2002:a05:6000:4026:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-42cc125247bmr30430964f8f.0.1764256656705;
        Thu, 27 Nov 2025 07:17:36 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c3016sm4283789f8f.1.2025.11.27.07.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:17:35 -0800 (PST)
Date: Thu, 27 Nov 2025 16:17:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v12 00/12] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <ollm3zbrolwoj4o3g3iga7vm5ldnolmkrmm5ry7sevepvnipk6@7akex53ryd4p>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>

On Wed, Nov 26, 2025 at 11:47:29PM -0800, Bobby Eshleman wrote:
>This series adds namespace support to vhost-vsock and loopback. It does
>not add namespaces to any of the other guest transports (virtio-vsock,
>hyperv, or vmci).

Jakub, Paolo, and other net maintainers, I left my R-b on all the 
patches in this series and I think it's ready to go.

I just have one doubt about the second patch. From my point of view, I 
think it makes sense, but I would like your opinion regarding the netns:
https://lore.kernel.org/netdev/hgz3rtpb3lvxzbygye6ziobfujfsl2yefh5t3ghrbbbknr6eis@ypifkm24ygja/

Thanks,
Stefano

>
>The current revision supports two modes: local and global. Local
>mode is complete isolation of namespaces, while global mode is complete
>sharing between namespaces of CIDs (the original behavior).
>
>The mode is set using /proc/sys/net/vsock/ns_mode.
>
>Modes are per-netns and write-once. This allows a system to configure
>namespaces independently (some may share CIDs, others are completely
>isolated). This also supports future possible mixed use cases, where
>there may be namespaces in global mode spinning up VMs while there are
>mixed mode namespaces that provide services to the VMs, but are not
>allowed to allocate from the global CID pool (this mode is not
>implemented in this series).
>
>If a socket or VM is created when a namespace is global but the
>namespace changes to local, the socket or VM will continue working
>normally. That is, the socket or VM assumes the mode behavior of the
>namespace at the time the socket/VM was created. The original mode is
>captured in vsock_create() and so occurs at the time of socket(2) and
>accept(2) for sockets and open(2) on /dev/vhost-vsock for VMs. This
>prevents a socket/VM connection from suddenly breaking due to a
>namespace mode change. Any new sockets/VMs created after the mode change
>will adopt the new mode's behavior.
>
>Additionally, added tests for the new namespace features:
>
>tools/testing/selftests/vsock/vmtest.sh
>1..28
>ok 1 vm_server_host_client
>ok 2 vm_client_host_server
>ok 3 vm_loopback
>ok 4 ns_host_vsock_ns_mode_ok
>ok 5 ns_host_vsock_ns_mode_write_once_ok
>ok 6 ns_global_same_cid_fails
>ok 7 ns_local_same_cid_ok
>ok 8 ns_global_local_same_cid_ok
>ok 9 ns_local_global_same_cid_ok
>ok 10 ns_diff_global_host_connect_to_global_vm_ok
>ok 11 ns_diff_global_host_connect_to_local_vm_fails
>ok 12 ns_diff_global_vm_connect_to_global_host_ok
>ok 13 ns_diff_global_vm_connect_to_local_host_fails
>ok 14 ns_diff_local_host_connect_to_local_vm_fails
>ok 15 ns_diff_local_vm_connect_to_local_host_fails
>ok 16 ns_diff_global_to_local_loopback_local_fails
>ok 17 ns_diff_local_to_global_loopback_fails
>ok 18 ns_diff_local_to_local_loopback_fails
>ok 19 ns_diff_global_to_global_loopback_ok
>ok 20 ns_same_local_loopback_ok
>ok 21 ns_same_local_host_connect_to_local_vm_ok
>ok 22 ns_same_local_vm_connect_to_local_host_ok
>ok 23 ns_mode_change_connection_continue_vm_ok
>ok 24 ns_mode_change_connection_continue_host_ok
>ok 25 ns_mode_change_connection_continue_both_ok
>ok 26 ns_delete_vm_ok
>ok 27 ns_delete_host_ok
>ok 28 ns_delete_both_ok
>SUMMARY: PASS=28 SKIP=0 FAIL=0
>
>Dependent on series:
>https://lore.kernel.org/all/20251108-vsock-selftests-fixes-and-improvements-v4-0-d5e8d6c87289@meta.com/
>
>Thanks again for everyone's help and reviews!
>
>Suggested-by: Sargun Dhillon <sargun@sargun.me>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
>
>Changes in v12:
>- add ns mode checking to _allow() callbacks to reject local mode for
>  incompatible transports (Stefano)
>- flip vhost/loopback to return true for stream_allow() and
>  seqpacket_allow() in "vsock: add netns support to virtio transports"
>  (Stefano)
>- add VMADDR_CID_ANY + local mode documentation in af_vsock.c (Stefano)
>- change "selftests/vsock: add tests for host <-> vm connectivity with
>  namespaces" to skip test 29 in vsock_test for namespace local
>  vsock_test calls in a host local-mode namespace. There is a
>  false-positive edge case for that test encountered with the
>  ->stream_allow() approach. More details in that patch.
>- updated cover letter with new test output
>- Link to v11: https://lore.kernel.org/r/20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com
>
>Changes in v11:
>- vmtest: add a patch to use ss in wait_for_listener functions and
>  support vsock, tcp, and unix. Change all patches to use the new
>  functions.
>- vmtest: add a patch to re-use vm dmesg / warn counting functions
>- Link to v10: https://lore.kernel.org/r/20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com
>
>Changes in v10:
>- Combine virtio common patches into one (Stefano)
>- Resolve vsock_loopback virtio_transport_reset_no_sock() issue
>  with info->vsk setting. This eliminates the need for skb->cb,
>  so remove skb->cb patches.
>- many line width 80 fixes
>- Link to v9: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-0-852787a37bed@meta.com
>
>Changes in v9:
>- reorder loopback patch after patch for virtio transport common code
>- remove module ordering tests patch because loopback no longer depends
>  on pernet ops
>- major simplifications in vsock_loopback
>- added a new patch for blocking local mode for guests, added test case
>  to check
>- add net ref tracking to vsock_loopback patch
>- Link to v8: https://lore.kernel.org/r/20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com
>
>Changes in v8:
>- Break generic cleanup/refactoring patches into standalone series,
>  remove those from this series
>- Link to dependency: https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
>- Link to v7: https://lore.kernel.org/r/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com
>
>Changes in v7:
>- fix hv_sock build
>- break out vmtest patches into distinct, more well-scoped patches
>- change `orig_net_mode` to `net_mode`
>- many fixes and style changes in per-patch change sets (see individual
>  patches for specific changes)
>- optimize `virtio_vsock_skb_cb` layout
>- update commit messages with more useful descriptions
>- vsock_loopback: use orig_net_mode instead of current net mode
>- add tests for edge cases (ns deletion, mode changing, loopback module
>  load ordering)
>- Link to v6: https://lore.kernel.org/r/20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com
>
>Changes in v6:
>- define behavior when mode changes to local while socket/VM is alive
>- af_vsock: clarify description of CID behavior
>- af_vsock: use stronger langauge around CID rules (dont use "may")
>- af_vsock: improve naming of buf/buffer
>- af_vsock: improve string length checking on proc writes
>- vsock_loopback: add space in struct to clarify lock protection
>- vsock_loopback: do proper cleanup/unregister on vsock_loopback_exit()
>- vsock_loopback: use virtio_vsock_skb_net() instead of sock_net()
>- vsock_loopback: set loopback to NULL after kfree()
>- vsock_loopback: use pernet_operations and remove callback mechanism
>- vsock_loopback: add macros for "global" and "local"
>- vsock_loopback: fix length checking
>- vmtest.sh: check for namespace support in vmtest.sh
>- Link to v5: https://lore.kernel.org/r/20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com
>
>Changes in v5:
>- /proc/net/vsock_ns_mode -> /proc/sys/net/vsock/ns_mode
>- vsock_global_net -> vsock_global_dummy_net
>- fix netns lookup in vhost_vsock to respect pid namespaces
>- add callbacks for vsock_loopback to avoid circular dependency
>- vmtest.sh loads vsock_loopback module
>- remove vsock_net_mode_can_set()
>- change vsock_net_write_mode() to return true/false based on success
>- make vsock_net_mode enum instead of u8
>- Link to v4: https://lore.kernel.org/r/20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com
>
>Changes in v4:
>- removed RFC tag
>- implemented loopback support
>- renamed new tests to better reflect behavior
>- completed suite of tests with permutations of ns modes and vsock_test
>  as guest/host
>- simplified socat bridging with unix socket instead of tcp + veth
>- only use vsock_test for success case, socat for failure case (context
>  in commit message)
>- lots of cleanup
>
>Changes in v3:
>- add notion of "modes"
>- add procfs /proc/net/vsock_ns_mode
>- local and global modes only
>- no /dev/vhost-vsock-netns
>- vmtest.sh already merged, so new patch just adds new tests for NS
>- Link to v2:
>  https://lore.kernel.org/kvm/20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com
>
>Changes in v2:
>- only support vhost-vsock namespaces
>- all g2h namespaces retain old behavior, only common API changes
>  impacted by vhost-vsock changes
>- add /dev/vhost-vsock-netns for "opt-in"
>- leave /dev/vhost-vsock to old behavior
>- removed netns module param
>- Link to v1:
>  https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com
>
>Changes in v1:
>- added 'netns' module param to vsock.ko to enable the
>  network namespace support (disabled by default)
>- added 'vsock_net_eq()' to check the "net" assigned to a socket
>  only when 'netns' support is enabled
>- Link to RFC: https://patchwork.ozlabs.org/cover/1202235/
>
>---
>Bobby Eshleman (12):
>      vsock: a per-net vsock NS mode state
>      vsock: add netns to vsock core
>      virtio: set skb owner of virtio_transport_reset_no_sock() reply
>      vsock: add netns support to virtio transports
>      selftests/vsock: add namespace helpers to vmtest.sh
>      selftests/vsock: prepare vm management helpers for namespaces
>      selftests/vsock: add vm_dmesg_{warn,oops}_count() helpers
>      selftests/vsock: use ss to wait for listeners instead of /proc/net
>      selftests/vsock: add tests for proc sys vsock ns_mode
>      selftests/vsock: add namespace tests for CID collisions
>      selftests/vsock: add tests for host <-> vm connectivity with namespaces
>      selftests/vsock: add tests for namespace deletion and mode changes
>
> MAINTAINERS                             |    1 +
> drivers/vhost/vsock.c                   |   59 +-
> include/linux/virtio_vsock.h            |   12 +-
> include/net/af_vsock.h                  |   57 +-
> include/net/net_namespace.h             |    4 +
> include/net/netns/vsock.h               |   17 +
> net/vmw_vsock/af_vsock.c                |  272 +++++++-
> net/vmw_vsock/hyperv_transport.c        |    7 +-
> net/vmw_vsock/virtio_transport.c        |   19 +-
> net/vmw_vsock/virtio_transport_common.c |   75 ++-
> net/vmw_vsock/vmci_transport.c          |   26 +-
> net/vmw_vsock/vsock_loopback.c          |   23 +-
> tools/testing/selftests/vsock/vmtest.sh | 1077 +++++++++++++++++++++++++++++--
> 13 files changed, 1522 insertions(+), 127 deletions(-)
>---
>base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59
>change-id: 20250325-vsock-vmtest-b3a21d2102c2
>prerequisite-message-id: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
>prerequisite-patch-id: a2eecc3851f2509ed40009a7cab6990c6d7cfff5
>prerequisite-patch-id: 501db2100636b9c8fcb3b64b8b1df797ccbede85
>prerequisite-patch-id: ba1a2f07398a035bc48ef72edda41888614be449
>prerequisite-patch-id: fd5cc5445aca9355ce678e6d2bfa89fab8a57e61
>prerequisite-patch-id: 795ab4432ffb0843e22b580374782e7e0d99b909
>prerequisite-patch-id: 1499d263dc933e75366c09e045d2125ca39f7ddd
>prerequisite-patch-id: f92d99bb1d35d99b063f818a19dcda999152d74c
>prerequisite-patch-id: e3296f38cdba6d903e061cff2bbb3e7615e8e671
>prerequisite-patch-id: bc4662b4710d302d4893f58708820fc2a0624325
>prerequisite-patch-id: f8991f2e98c2661a706183fde6b35e2b8d9aedcf
>prerequisite-patch-id: 44bf9ed69353586d284e5ee63d6fffa30439a698
>prerequisite-patch-id: d50621bc630eeaf608bbaf260370c8dabf6326df
>
>Best regards,
>-- 
>Bobby Eshleman <bobbyeshleman@meta.com>
>


