Return-Path: <linux-hyperv+bounces-2219-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14CE8D13E0
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 07:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FAB1F22FEF
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 05:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260DD4CB4E;
	Tue, 28 May 2024 05:29:00 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B34CB2B;
	Tue, 28 May 2024 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716874140; cv=none; b=bIa9qHzP2D7DnFWQ4aScvUSMO1XD0WmAu2bN7u6e+bBAHBg8U1WBKLcmYmAqVYXNeh/WvgQ8xClYXvBA/DgWDjfXtPg4TmsDeLxLGaIEUpxdsHFfUebIzzGMZa09TNmHHHvNZ30yVeskHUsRrjoPl+973oD86puHFszV0mt7l48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716874140; c=relaxed/simple;
	bh=CLuvCiQHX/FFvOvielNOZvHNT3ZOiWDDKU/lbAwRp9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6n9tcCWSaN59dd4D1PzLSva9zS/kdcm0JeVz6e4JtgkSTYam05e1Zc57KPHyD7RrBpWRCz6aPx7u/Bgwi8Ma/qWE2vxLLFWD46ls+dCMcmgPfZclQNyEcDjKCWZzrdP+62NRd0ECI9PomA/g32IpVJdrZn7OmrzX9HLPA9RZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b97a071c92so240317eaf.1;
        Mon, 27 May 2024 22:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716874138; x=1717478938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klaVH2ivgMXOV5dASJZrrHq1usXyfBuaw8Xvo5RoF/Y=;
        b=qlLC6JeuzVzFFWtpRIdtIpa1Jie3kknKoXTyrHs858/CNPPwAnlntwTn9D4A0lvJ1C
         80v+NPAPBY49v+mbHRI5z+LEv5ZwKfpqfGD2GD4aevufTgg4tqRKbeyITQoEylBkWw7G
         b1l64oVlmwElYB39ADVjCtXN/Bhq8TWUMgPniWSTJFvek366LFUAV0yQlhO08a9BguYj
         Aw4urKO6saKW56oFHRSVX8I36raO5CE/cqTH4D1imwGqZqUOtx/dZJMiG3hSrL0oDJan
         7y70vPDtf1Vihd56U1rQIiRJlpuVzfADl5PnhIBYvu9A+f/5RXpCRzTqQ4WWbnOyt6N3
         2n4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUka84oqYDIVtsdkMR5KjOQHkSXNWabnmSRddYbDmAcfeDbJfzif+9RbDivNjEpgOXW/V+OJs/DLgQXSUORRqA+5K/Ina2C94x1cxSdyszIyA+c/IEIozZbLcRixBdJFqhtXp4bIVpRfmFI3I8Hgx99njRqWY9msu1LVVj6gxaVh9GA4VEf
X-Gm-Message-State: AOJu0YywSw6hL/yCQDPcSi56a6GS7SK4YTxOfl9Hz9dp/9IDsegPMtYy
	FadTugXsxdv+Ca2/Wn41X0om7hBwqshynyYI8cxoMH32FuAodrgUpTyXMg==
X-Google-Smtp-Source: AGHT+IHc/NM9LZnLrPnOHgvf7ewqZ+si8nHZU2X6yykjnbEUsYp1NiqJ6b0ieIxBP8Q41vngXWjMEQ==
X-Received: by 2002:a05:6358:c115:b0:186:119d:8c16 with SMTP id e5c5f4694b2df-197e546657cmr1022970455d.23.1716874137877;
        Mon, 27 May 2024 22:28:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682227f1d6esm5824813a12.49.2024.05.27.22.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 22:28:57 -0700 (PDT)
Date: Tue, 28 May 2024 05:28:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	kys@microsoft.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Documentation: hyperv: Update spelling and fix
 typo
Message-ID: <ZlVrmJ26FR8_MMiJ@liuwe-devbox-debian-v2>
References: <20240511133818.19649-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511133818.19649-1-mhklinux@outlook.com>

On Sat, May 11, 2024 at 06:38:17AM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Update spelling from "VMbus" to "VMBus" to match Hyper-V product
> documentation. Also correct typo: "SNP-SEV" should be "SEV-SNP".
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Applied. Thanks.

