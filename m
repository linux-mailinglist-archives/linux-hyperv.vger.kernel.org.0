Return-Path: <linux-hyperv+bounces-8210-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A31C3D0DFF5
	for <lists+linux-hyperv@lfdr.de>; Sun, 11 Jan 2026 01:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60A6D3023D76
	for <lists+linux-hyperv@lfdr.de>; Sun, 11 Jan 2026 00:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D26B67A;
	Sun, 11 Jan 2026 00:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWbu5R2O";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mu3W6dAU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78C1862
	for <linux-hyperv@vger.kernel.org>; Sun, 11 Jan 2026 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768090337; cv=none; b=KNEtp9In+9cgLz95Znne7ub/ln5stLcZ0PaTHk5scrKPA2LRAuQ6bBUaMB/XTnFnHgGLoIEcDDb4bl406L+lODOyRrwz7JAlAEoqn3SApLZx10GncKOxk83IULKpxbuME0SXTERJ0dtubTN/rbd85HkVtwhZpTYALbMafDT4O2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768090337; c=relaxed/simple;
	bh=mLWLZ8V/CeaK+tkNrj5VuZDldGSy5v1mTtg2DMNYb/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSmso1/wIJ0uA9nhGSneOQ9PV+DZRyDMkZJZXxlIW2gI77v2ziLdlajLXYtrG1Jin3x7wigaNZ7feVESQ4YKJ3Zp6LDnldTLEstxiZJ+6khU6L9HpoGmlIaoBx3y3N4a5TidiSNEjiEqrKVM3wxfZL4Zlj95ZXr+GcS1N0lm/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWbu5R2O; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mu3W6dAU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768090335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rJ92NuxJ/FhkA7sHAwthrAyvDj9go5GB1uGyDHAuqv0=;
	b=GWbu5R2OkHOW1Q6dRltZRMiANuPvs6IRjCQOxp4RvFkyYGj7UUa6g4XA9G3ls7impXskL1
	T0TPI/6Gn6oDC4+SFNTQeJo0iaskfFol2zJP4lXEa2droYI0NKd9m2xHcvsSYyoX1XA4At
	ZimHuwip6MvoYEBwR2MyNRz8FAIpTgQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-kYvCHp7cMNuQmm_iTClXgQ-1; Sat, 10 Jan 2026 19:12:13 -0500
X-MC-Unique: kYvCHp7cMNuQmm_iTClXgQ-1
X-Mimecast-MFC-AGG-ID: kYvCHp7cMNuQmm_iTClXgQ_1768090333
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso62452285e9.2
        for <linux-hyperv@vger.kernel.org>; Sat, 10 Jan 2026 16:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768090332; x=1768695132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ92NuxJ/FhkA7sHAwthrAyvDj9go5GB1uGyDHAuqv0=;
        b=mu3W6dAUGHim0Hn7QT5H2ljZEnUp5X0zmSP/8oJdN38ucQYE9KHA7KLn9IZsUmj3z7
         gyqCy/qwhszVUTW7Ar5bhF5GUU/mQIU6URCfYm57MCuK3g4qAIwZx2LH7vW1alXDYAus
         vmM2ctz7a7wawMY/Pt3dCNnlFrmO9tDda+ibYAl7htBeh050CfYfeP/GuRAdaSQJ5IFp
         XTHc8LSqUJFtbSQrVV5dZNqx/9f+imMwIWsGnMmfrHQ2p383vyXu3VAaOc8JCNXPbr27
         8hzBkjw2+Zi+DZSfrhxlpod48bj7F6l6tH/5y8nw3PHClaFHmp9+3ObJdUpF3TRwEgik
         DmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768090332; x=1768695132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJ92NuxJ/FhkA7sHAwthrAyvDj9go5GB1uGyDHAuqv0=;
        b=iLoQElwa3de8GLfYEyixLeCxt9Vj9cCLqnN4/GJlTzacwqxzNz2rlokuHkFO7FfcGz
         3faSsmL750VHPsSzplvbtwM7kYBPepEL4Fju0aA9thlrrkBVdwkrIqRTrwffYohTJS8H
         hi/Sm4jyTbehDcYQi+y1iIQr5WV2QhPrQPNiNNEAxA0NHLW22iJWVlPXMlvlmvenTsSc
         SxAZDIDmVa/bfzCPeak/P5LspDbrPOuWbEZFRviVZH9pN/q6iHiRq5sBQjfGz2nwdzZS
         iD4pMtZ2hK6q35ieVQCRO89OH3pfK702FapyLXZyczM8oOT5DocnZudlww3TtlGNl8TM
         DUpw==
X-Forwarded-Encrypted: i=1; AJvYcCW2znR7/C5DRtR5QY/zp/SuXgfOECAnPvAlVeHH3wWD14VScIEJCCf64nnFyQ+SMn6cfSCYFSZHMJN6/OU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyefk//XyHcQf5iQ2pzcDIoExX7tDlvZcQsMrO6/ddCu+MsWYNO
	vKpP68dP6zce0A8E6kVDLVIRRFIDSwwOQPzyea6gFRhQPXt8rPr+SM1aeG1BcpWiC1kkKp3o4ni
	idXdyiCfl30WoLkGYx1IWPUUJvxcfsPAj4s5ybvvJRojcqhmQdPMmqCDoxrdkymDcVQ==
X-Gm-Gg: AY/fxX4TOdZ721uMaY7/tEH3dJ8CKhRd0YGzUcXe5ntWLRQ89b73K96gD8nYR0OMM62
	+AYqLIGT5Gag63mRf/c8eKgcjFh3Frd1qGc0mFudNdq1r27qsjoW4CO8VWyAUXsGIm0CzaDsmDe
	FmmWK+vCHqVYRcLwxEcc3H7hNgRxikUrc8zyLL3PLidUvuVSFy0cmJterE1/qzMM+u534B66qpH
	hZGiV5XlqxR4kwUwxbZUWZrgxLdXxK95LT/Ctvbrf5eIa4rTfr0Jcp9Sn6O1+XyQNekeToGsk/Q
	29f8yTMkCiEOWCEMhr0D7F2CXa6l8FbUv5tGAz/Szs9ZvPNStoGIVv0tkA8EWA+Qm3pj+rbqVNw
	xYr9fdA9V0UdGocbD3EjMcgcbEWCBe9w=
X-Received: by 2002:a05:600c:4fd0:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d84b1f7efmr165064635e9.10.1768090332625;
        Sat, 10 Jan 2026 16:12:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnuDsqC9m+l3yDfJUMvz3utaUAG5Ge2RfD+SugU7SA1yuuWtgjR7DEiLIEaKlXtpa9H3hyeA==
X-Received: by 2002:a05:600c:4fd0:b0:477:5c58:3d42 with SMTP id 5b1f17b1804b1-47d84b1f7efmr165064445e9.10.1768090332218;
        Sat, 10 Jan 2026 16:12:12 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41f5e0sm272650555e9.8.2026.01.10.16.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 16:12:11 -0800 (PST)
Date: Sat, 10 Jan 2026 19:12:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <20260110191107-mutt-send-email-mst@kernel.org>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
 <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>

On Fri, Jan 09, 2026 at 04:11:12PM -0800, Bobby Eshleman wrote:
> On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> > This series adds namespace support to vhost-vsock and loopback. It does
> > not add namespaces to any of the other guest transports (virtio-vsock,
> > hyperv, or vmci).
> > 
> > The current revision supports two modes: local and global. Local
> > mode is complete isolation of namespaces, while global mode is complete
> > sharing between namespaces of CIDs (the original behavior).
> > 
> > The mode is set using the parent namespace's
> > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> > created. The mode of the current namespace can be queried by reading
> > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> > has been created.
> > 
> > Modes are per-netns. This allows a system to configure namespaces
> > independently (some may share CIDs, others are completely isolated).
> > This also supports future possible mixed use cases, where there may be
> > namespaces in global mode spinning up VMs while there are mixed mode
> > namespaces that provide services to the VMs, but are not allowed to
> > allocate from the global CID pool (this mode is not implemented in this
> > series).
> 
> Stefano, would like me to resend this without the RFC tag, or should I
> just leave as is for review? I don't have any planned changes at the
> moment.
> 
> Best,
> Bobby

i couldn't apply it on top of net-next so pls do.


