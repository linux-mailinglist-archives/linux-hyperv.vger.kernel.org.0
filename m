Return-Path: <linux-hyperv+bounces-968-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0762D7ED853
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Nov 2023 00:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313FD1C208FA
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Nov 2023 23:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F326B2EB12;
	Wed, 15 Nov 2023 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="E3Am9kHr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253B8192
	for <linux-hyperv@vger.kernel.org>; Wed, 15 Nov 2023 15:53:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc921a4632so2383825ad.1
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Nov 2023 15:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700092380; x=1700697180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNz1LZLWLqztNC1mkWelul3LmT7uMEIxjhxqq8dOWJk=;
        b=E3Am9kHrzGiKvuQ7Wd3p1RtKWgvVBsR+Hwym+gYpCIu1YzMG6e2EEDY7D97fEWMe09
         xieMnX9zRJuZ5cfKNmtKGSjJRQjVeDwjntPuBLtHAsxeucEELoD57FBXzD5QXgq02q+5
         FxdQ99Ik8qW7DtUz3WqOsHOOS0kOka5F+vBXD392JG+jYsC+FLMfZZylaH99OLbw4Odu
         L4TcFcqH/JF/GXMfaapgLL8e4+1C2y9dnXvc1G8+ydcIP6b2UXT5qfOYS48fy3RwUdRR
         8ue7LgHqswrHw+e9Kj8VPLFhxrWIOtj/tP6qFh+7jNFBKGHUN2p0wHUIHaN7oHqsj21H
         0hHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700092380; x=1700697180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNz1LZLWLqztNC1mkWelul3LmT7uMEIxjhxqq8dOWJk=;
        b=bhoxSQWxiLvqm6T2+tkP45LKMbSOWID3RZlGubVTHmcG8wdmc/X5j6FqlSMOkAnOiA
         HrKb2SPeykYvSdvOkwoygFVNNHY4+qpvxFrNrC6CVKiT9cIVJn3Oxzhkvm2xzcjf6tbD
         JTPlvz0AR5BYJm1i9rvptpFkmrqsHwahASzYf78irLEtKj/hWFctoHZgdTUxn/98CJEr
         AKhmLgr00qHSNJ2OxzkcA/CM2gOF/SuEIrpT2uHMr8qkjidXnmtn2HoZ2QwKSZ3AAA8r
         lw3BGPaChufk87MsHheX3gen9J/YU+ezpyx1LZCVjU+/RGLCK4gnM9vBtrMJOUUbVH+w
         5cHQ==
X-Gm-Message-State: AOJu0YzwTm0G09wgBOuxTw1bhXqwAp79y8mx5CBCZJHiNfo3T+roDwrL
	d7IX8xzO+8uWX4YJ+J+O/hYQsA==
X-Google-Smtp-Source: AGHT+IFXwoOe3aV75o7N/RNqxVPQxI4r3UiEus4sBc1W5lL/WagI4kLVy6eVv3qf/8n+XUliy6+PZg==
X-Received: by 2002:a17:903:2341:b0:1c7:5f03:8562 with SMTP id c1-20020a170903234100b001c75f038562mr9891201plh.30.1700092380545;
        Wed, 15 Nov 2023 15:53:00 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001c9ba6c7287sm7923702plb.143.2023.11.15.15.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 15:53:00 -0800 (PST)
Date: Wed, 15 Nov 2023 15:52:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH net,v4, 3/3] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Message-ID: <20231115155258.5b3f360b@hermes.local>
In-Reply-To: <1699627140-28003-4-git-send-email-haiyangz@microsoft.com>
References: <1699627140-28003-1-git-send-email-haiyangz@microsoft.com>
	<1699627140-28003-4-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 06:39:00 -0800
Haiyang Zhang <haiyangz@microsoft.com> wrote:

> +static int netvsc_prepare_slave(struct net_device *vf_netdev)

It would be good to not introduce another instance of non-inclusive naming in network code.
Please think of a better term. Can't change IFF_SLAVE but the rest could change.

