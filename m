Return-Path: <linux-hyperv+bounces-8203-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B03ED0C9AE
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 Jan 2026 01:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 292CB303ADD2
	for <lists+linux-hyperv@lfdr.de>; Sat, 10 Jan 2026 00:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2749781ACA;
	Sat, 10 Jan 2026 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF5/fIAP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78851CFBA
	for <linux-hyperv@vger.kernel.org>; Sat, 10 Jan 2026 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768003877; cv=none; b=ces8x0E3GHNiZhx7oxPYUADUOKZpPxhic2DNbfrS+5kyFuXsCYKDIEHqqbTBWlJ7CXz+vsIjUGsmv6qf8Vkzpv62kLDWztgI+XXWvx65ZkNQLPnDC1qPEBLPAjAQ5mgb7FhIZ0qBEbmeezW+HviNwCfhdlXeV/TMs7PDZmE6iIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768003877; c=relaxed/simple;
	bh=XszBXPJ18HkMpycCWMX0Y8i3Aoh/kyFsduWJiX9qSIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgTw4YLfACgF6Yp5Mtgy9Avo+OGv460nBwT2EzKRlnv5vWRI8pgYV26XHxU7Y4pChoTG1uU0xXx8yjFi08s0PVjIWuTOUSl28ySTxZcVZB9lBXV+KxuDNCgg3bakFs0C7H4ocMvNZ6zHdiRyxEH0V9fLmwXiyaMmXu7P9mrLc/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF5/fIAP; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6455a60c11fso4019369d50.2
        for <linux-hyperv@vger.kernel.org>; Fri, 09 Jan 2026 16:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768003874; x=1768608674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6N0A2c2LYMc0dJDgYzdUUiKfOdoal/WEyiilk+5HTkg=;
        b=WF5/fIAP4AEyO4f6KWSJP2rwaSy/sViblkfSeeU8EGHt4W8zcGu8GdInztygNBG+SI
         lFZMtf5mk92Bho0bl/kz0wrylefbq54djvfDKFetQZqFm4VltIFlMyuYZ3TYsee7EuPv
         cuFATTU+AojUbvwayi9w7OyNstSzzzIWEbhQr08urKNmtzyFQEASvw8VCOBtpjn1hEZ7
         /S6AXS4ADril+8pCuPrnQcp3DFjvjtLVBL9cCPyinaRd8F5C9kJqxbl7/LUxO4bKzb5y
         2VTvsnHADEUfrU8ytID59HZXZVXxMG6DT+qvAAEn0faaDEgjA/ym8ZI4sdu6WxDKie2G
         EoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768003874; x=1768608674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6N0A2c2LYMc0dJDgYzdUUiKfOdoal/WEyiilk+5HTkg=;
        b=r3h746uepulhV7nVuChtOD63YO17cF4G1lXnJXKEwmFyY5nrOWIsR8yYKfM18+FkHT
         t5jk/+BFQV+AoHUSZPvwe/J59CfpyLvSlZE1lTCodEzd2of63c8ZxRW3EhVph9aeVVUi
         Jrz+OKACROUkdB/4814RRw08QjW9VxPubwrwAf5u7sE7IV8i3fph6k0y6Jxy7te4ekCr
         X8n77KcwDXPleFL9wZmEKJ5dLCm5axQ+4uUzzAzuYqvFUbJFqjLFP0+IYVynlGCaEaun
         /YsfEQWqZg31+B68//EzMxv5qaPF0l8TYr8T+r1QuuRByr9+K+QX5cpIxfOAZ0t99U9d
         wRqg==
X-Forwarded-Encrypted: i=1; AJvYcCV6q66abz5Ss4kCYt6Md8sXWP/hn4xs+c4XWshuWfbttJ3PClet2mX224A/Sib69I2r/X/suRLmLTwwVlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9uCkWrMmkeiX5iRiXnfwawNPa0SoLzQFBL3YBdgzK2D8hPCfV
	YwYcVj2rjHiyUdFep0UAGzlko6060xEMu44tIqQZ+GIAwBHeo9r8lrnQ
X-Gm-Gg: AY/fxX7l4B5KRPncxBM8Kn2ViqK/LllI/im4Vuw+cmmf0KfhqWm+OY+IwpMDmhOtaHS
	3eRycc7UPqUMCdPyO7+W+yKBChB640t7itr8toq73rzLF9guCJprf5IigxMLkLuhxWFEt/aSgHU
	vvLG8yYbVpbW+Bu/YquajxzcfLa4oSd6VK6XcAeNrN+pJBvxUwCpMyXYaHMpbeVFtbcB47s9sIu
	Pq9JyZ3kelsIOnCN5bNGuEh3Eom244pfLGBCfyHs2+YS8Iy5+dmzFdC1tFL/JoAJKhsUhxNEwP8
	/K4FCg3POxDcXN7E5hTrEldsc59w6o0waSD1RSSclNu0vt2CZ5/4U+zYE1GOzOblAHTIeua62kI
	fqDhMME0lNpy1/J4odqDkI7/bdDiU6XUKNeib6dFc5GmisKLrCFIbA5Iwdk82S0PYLQAfkkZwZF
	oj4ZU0WLpxeXfSArN3Bknmby5Ir4w9S2sGzw==
X-Google-Smtp-Source: AGHT+IE5CW/VP1bFR/Dosae0XD0Rb9scRJI8ZCC2GQQ5cF/xpuuKEVGU70q9buii5G2BZNROzhlUqg==
X-Received: by 2002:a05:690e:1611:b0:644:7712:ed72 with SMTP id 956f58d0204a3-64716bd7b38mr8182868d50.43.1768003873903;
        Fri, 09 Jan 2026 16:11:13 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa553ac3sm46524707b3.5.2026.01.09.16.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 16:11:13 -0800 (PST)
Date: Fri, 9 Jan 2026 16:11:12 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH RFC net-next v13 00/13] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aWGZILlNWzIbRNuO@devvm11784.nha0.facebook.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>

On Tue, Dec 23, 2025 at 04:28:34PM -0800, Bobby Eshleman wrote:
> This series adds namespace support to vhost-vsock and loopback. It does
> not add namespaces to any of the other guest transports (virtio-vsock,
> hyperv, or vmci).
> 
> The current revision supports two modes: local and global. Local
> mode is complete isolation of namespaces, while global mode is complete
> sharing between namespaces of CIDs (the original behavior).
> 
> The mode is set using the parent namespace's
> /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> created. The mode of the current namespace can be queried by reading
> /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> has been created.
> 
> Modes are per-netns. This allows a system to configure namespaces
> independently (some may share CIDs, others are completely isolated).
> This also supports future possible mixed use cases, where there may be
> namespaces in global mode spinning up VMs while there are mixed mode
> namespaces that provide services to the VMs, but are not allowed to
> allocate from the global CID pool (this mode is not implemented in this
> series).

Stefano, would like me to resend this without the RFC tag, or should I
just leave as is for review? I don't have any planned changes at the
moment.

Best,
Bobby

