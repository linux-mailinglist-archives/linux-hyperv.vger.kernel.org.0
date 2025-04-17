Return-Path: <linux-hyperv+bounces-4958-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4A5A920F2
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351C33B565E
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Apr 2025 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1024025332B;
	Thu, 17 Apr 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="H3yATVk1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60C252905
	for <linux-hyperv@vger.kernel.org>; Thu, 17 Apr 2025 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902658; cv=none; b=gHY9EWw77peBe6RhMM6C1Up1MTqVPNKzryEzN+MGBCfIa8t1oTim9VEi7TQbcK3Z0FETFn8PGXd8IJp+wNzDF2ZNFDLszIfaTfa1Tp9mjvL8kAQ7ifgj5cU0HV7jyW659oBxb0gk81tskLGHcsYq8M+FltncLNK38bNbd3WLlH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902658; c=relaxed/simple;
	bh=LiZgga9x8uNn0x7WdTDXbakOF44Ru5INCev66F2o+Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAsaq5LqmKVBDSY4L296UVe9Upfo5vlF2hb3YynJdvaeZC5HQDGJV0j6sMbUnQafvUAnZol9cvMDpczboQ5XyYN+QcbQrBoKow37ZpLjq2Fkp6gyWUpXQi4qnioaXC/o8JrSuFkQGDLTbJ/fwqqPAeTEgQ+PUI1l9oBBEDRRxWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=H3yATVk1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224341bbc1dso10350105ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 17 Apr 2025 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744902655; x=1745507455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LiZgga9x8uNn0x7WdTDXbakOF44Ru5INCev66F2o+Dc=;
        b=H3yATVk10aZqoRI+w4nNhDNAcSrm+D72kf09ipil/lhZBQVG98+L9kHkPcmnSnwazQ
         2l2q7/rcLpNyHl7W14wjQCbWN87G0IAsm+Yej1cduBZyRY+bLzSw3rdEYxijZFieiE5K
         4p9sZvZQrU1T5YW0n/Phw1rSXkT4kX9Je/Pl622+TtYHoFzbnncoMrFYet2UFNdX7dEZ
         Kp5GDmv6d0PucyJocp1zYdAefTVH68d510dC+sFSGKo4O3dpzsf/SX5osPX6hm1NRhbn
         mn8Q/7MwclR7BEHoMAaKF+jTuamIjIVUOtP2h2aefp90oQRbxnCBj4UUds3GxtLFjNgk
         ZaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744902655; x=1745507455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LiZgga9x8uNn0x7WdTDXbakOF44Ru5INCev66F2o+Dc=;
        b=mbdRHECv6qSl7HWbgP/55DqVqiu9THGPOzdG1Uip++ccT8Kg6WcyjM03pncZ6CrQHp
         TtKiVoHljpZl5HcYMuRf9cGVTpTojLx85jq6areQtquroRpq66LkjjZnk2Trf8FbHYl9
         PTUcDomx/iNuysAndggQhy63YfAvqzZK3tTeWJWyEz+6txoYkkWEpb+QQg8toGVR7xJx
         zdHWsj08u09zjLr3zFt0gDaMvdtKOqeKBI2GNETdj7wktgfebrq/bmT/sIu/cGLmM77E
         aFdsX7/DCH5LxbT54yZELv5hXtlr3MM9H1Z1AoGlFZ8xdz7P+PRA8Q31LU5Ta9ltTTaT
         u3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVbbk20Y15pAXU5qojzsTmiziql6PknBUWTXAm/mUm6hqg4CK2ZZ6F8xfEV0V3k8tfZiqfaVUlHLRzQ1Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1Eyg+mr2PtMgeg0VlzQMr/c38LykH5m1sYPKfGRfaNmI2MG1
	qWJirnB/i+gpnumPW7m9iEO/E/xLa4J1u9zXZHmtUlLB5WA9E+tIekATYWWCX2c=
X-Gm-Gg: ASbGncvNOuB1tqvEnDRLkgga+9A3qUVY1y1guKwvhyJnECXccUBx+YZG8CGXdfns45+
	yHUP96w7w3RdwmX0/3gJ7KcMNm1y043SYD6Yj38K4uzYp1JHisIxKb0chPhq57Aw0vfaw20ebiX
	5jcjHWFgUXMai5/Tf1ZLimdRCWlTpzE3UaqFHvZ09hWEuiwMCw0lhFxq0kPLVXPeC5hGuKLt8g3
	u4ybZ5aauJ/NN9SZk40W842JdiHlZ5ZnVEWqApgrhVnoqqKweRY1gGUDwO+hoHPOhW5A2Tmu2Yt
	hlGAMRwUOYGq2cQ5t0qi8lPrdCzVlkBXfPhwl9dXkfiDPABhTqfoC0rhSbsz0CsOOhiLSlsp7iS
	ESG+hnp9r8jyFDzy2
X-Google-Smtp-Source: AGHT+IHIP5FBpE6QRyj07ov+jrBL6Cb9idEsBOVjWQ1/IColpF0qdvEnnkroDFpHC82/JIDmUgRLTQ==
X-Received: by 2002:a17:902:f642:b0:220:c813:dfd1 with SMTP id d9443c01a7336-22c359734c3mr102186955ad.36.1744902655602;
        Thu, 17 Apr 2025 08:10:55 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c210esm12348763b3a.41.2025.04.17.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 08:10:55 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:10:53 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 kent.overstreet@linux.dev, brett.creeley@amd.com,
 schakrabarti@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, rosenp@gmail.com, paulros@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 2/3] net: mana: Add sched HTB offload support
Message-ID: <20250417081053.5b563a92@hermes.local>
In-Reply-To: <1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
References: <1744876630-26918-1-git-send-email-ernis@linux.microsoft.com>
	<1744876630-26918-3-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 00:57:09 -0700
Erni Sri Satya Vennela <ernis@linux.microsoft.com> wrote:

> Introduce support for HTB qdisc offload in the mana ethernet
> controller. This controller can offload only one HTB leaf.
> The HTB leaf supports clamping the bandwidth for egress traffic.
> It uses the function mana_set_bw_clamp(), which internally calls
> a HWC command to the hardware to set the speed.

A single leaf is just Token Bucket Filter (TBF).
Are you just trying to support some vendor config?

