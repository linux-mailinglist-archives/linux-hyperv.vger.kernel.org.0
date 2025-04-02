Return-Path: <linux-hyperv+bounces-4776-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09112A78AEB
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 11:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8C216EC2F
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 09:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A47233D85;
	Wed,  2 Apr 2025 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cl19ofkn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D06233705
	for <linux-hyperv@vger.kernel.org>; Wed,  2 Apr 2025 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585715; cv=none; b=ZHDHb++Kf7zJljB782myR89bIBS8MfkOgDhcBit5UMvUgjxuwPWvnyGHxGhm4gpfEqHcviRvFwihiEvzi/RDTlW1Mcgg7anJ2lQORq2s/K7wGK9dCV1PwUX+cD8ScuuVzrJGRMG/017dczWnxXVdD80FxS/h4+GOv0llw/AmGYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585715; c=relaxed/simple;
	bh=cZ7/ajwbjD8GIcf5QFa6HNRaYw2T8X0YKhZc5lgbrz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsqF4BDLm4MWM38u7xZ401CUd0H62gMu6uYFTj+W0qsD5oW9Zc2ADttz8PwvvpcBVGiMoHZnTmSbF0MyEPCC+I3nvM0qR+UF2306Sef2yNfc0ei6gWl6XtvKdJa1WQ8nZIVFfD0YYDpCLpEoWKXgi27Vkg+x8q9YG1t93x5/RAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cl19ofkn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743585712;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=sgCDsYKq2u4or2JXW0oRsRoKCnIqWshzdEf66OFf/wk=;
	b=cl19ofknZmagUgSWaX1BgxScr/t/iqaAhxsLEp20um+YlOFSXiIPdwltT382Y/7qn5+eiR
	H4liuYPKwP1lG+M43eZcsOYlavDZKp3/GvAbVxz/DqG/3GP0q+K/+R6dy4skTx/xV7RRCS
	2TQATXvecq9+cEz/eyiW/sl1j1P/yOY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-_E2shaWEPoat1eOwd9jpGA-1; Wed,
 02 Apr 2025 05:21:49 -0400
X-MC-Unique: _E2shaWEPoat1eOwd9jpGA-1
X-Mimecast-MFC-AGG-ID: _E2shaWEPoat1eOwd9jpGA_1743585707
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BA6619560BB;
	Wed,  2 Apr 2025 09:21:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 463DC19560AD;
	Wed,  2 Apr 2025 09:21:40 +0000 (UTC)
Date: Wed, 2 Apr 2025 10:21:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vsock: add namespace support to vhost-vsock
Message-ID: <Z-0BoF4vkC2IS1W4@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com>
 <r6a6ihjw3etlb5chqsb65u7uhcav6q6pjxu65iqpp76423w2wd@kmctvoaywmbu>
 <Z-w47H3qUXZe4seQ@redhat.com>
 <Z+yDCKt7GpubbTKJ@devvm6277.cco0.facebook.com>
 <CAGxU2F7=64HHaAD+mYKYLqQD8rHg1CiF1YMDUULgSFw0WSY-Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGxU2F7=64HHaAD+mYKYLqQD8rHg1CiF1YMDUULgSFw0WSY-Aw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Apr 02, 2025 at 10:13:43AM +0200, Stefano Garzarella wrote:
> On Wed, 2 Apr 2025 at 02:21, Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > I do like Stefano's suggestion to add a sysctl for a "strict" mode,
> > Since it offers the best of both worlds, and still tends conservative in
> > protecting existing applications... but I agree, the non-strict mode
> > vsock would be unique WRT the usual concept of namespaces.
> 
> Maybe we could do the opposite, enable strict mode by default (I think 
> it was similar to what I had tried to do with the kernel module in v1, I 
> was young I know xD)
> And provide a way to disable it for those use cases where the user wants 
> backward compatibility, while paying the cost of less isolation.

I think backwards compatible has to be the default behaviour, otherwise
the change has too high risk of breaking existing deployments that are
already using netns and relying on VSOCK being global. Breakage has to
be opt in.

> I was thinking two options (not sure if the second one can be done):
> 
>   1. provide a global sysfs/sysctl that disables strict mode, but this
>   then applies to all namespaces
> 
>   2. provide something that allows disabling strict mode by namespace.
>   Maybe when it is created there are options, or something that can be
>   set later.
> 
> 2 would be ideal, but that might be too much, so 1 might be enough. In 
> any case, 2 could also be a next step.
> 
> WDYT?

It occured to me that the problem we face with the CID space usage is
somewhat similar to the UID/GID space usage for user namespaces.

In the latter case, userns has exposed /proc/$PID/uid_map & gid_map, to
allow IDs in the namespace to be arbitrarily mapped onto IDs in the host.

At the risk of being overkill, is it worth trying a similar kind of
approach for the vsock CID space ?

A simple variant would be a /proc/net/vsock_cid_outside specifying a set
of CIDs which are exclusively referencing /dev/vhost-vsock associations
created outside the namespace. Anything not listed would be exclusively
referencing associations created inside the namespace.

A more complex variant would be to allow a full remapping of CIDs as is
done with userns, via a /proc/net/vsock_cid_map, which the same three
parameters, so that CID=15 association outside the namespace could be
remapped to CID=9015 inside the namespace, allow the inside namespace
to define its out association for CID=15 without clashing.

IOW, mapped CIDs would be exclusively referencing /dev/vhost-vsock
associations created outside namespace, while unmapped CIDs would be
exclusively referencing /dev/vhost-vsock associations inside the
namespace. 

A likely benefit of relying on a kernel defined mapping/partition of
the CID space is that apps like QEMU don't need changing, as there's
no need to invent a new /dev/vhost-vsock-netns device node.

Both approaches give the desirable security protection whereby the
inside namespace can be prevented from accessing certain CIDs that
were associated outside the namespace.

Some rule would need to be defined for updating the /proc/net/vsock_cid_map
file as it is the security control mechanism. If it is write-once then
if the container mgmt app initializes it, nothing later could change
it.

A key question is do we need the "first come, first served" behaviour
for CIDs where a CID can be arbitrarily used by outside or inside namespace
according to whatever tries to associate a CID first ?

IMHO those semantics lead to unpredictable behaviour for apps because
what happens depends on ordering of app launches inside & outside the
namespace, but they do sort of allow for VSOCK namespace behaviour to
be 'zero conf' out of the box.

A mapping that strictly partitions CIDs to either outside or inside
namespace usage, but never both, gives well defined behaviour, at the
cost of needing to setup an initial mapping/partition.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


