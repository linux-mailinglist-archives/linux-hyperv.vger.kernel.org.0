Return-Path: <linux-hyperv+bounces-7643-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCA9C65ADB
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 19:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60DCD4EDB11
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F33430AD19;
	Mon, 17 Nov 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hHtLGW3k"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD8C305E00
	for <linux-hyperv@vger.kernel.org>; Mon, 17 Nov 2025 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763403112; cv=none; b=jhvIW+KlgYadGcCQfpMLc7YvzHuLEFQZ8DvkiX9OGepIiSAAMVIt/hrXWsfBi5PxeQrcTxrd82xyYqgrt4MJVST7tbjow1extpBee7PrluxncvA+4ecdaZb1K8UxVzDp+PWxTihYdt6V/yL/ErvTXChI6yP9WDgY2v/JA8oyeRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763403112; c=relaxed/simple;
	bh=O7RpA/KmSd4G/hqnUQJhF6HWLcZQ2ssf+Cm4ZqmVphY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFBfo/unX0g7HTWA8U0KU/kzToLOnJQlzlDOqqabFxhP+Do+j1y07G90clz78oixSuHKif2iu1OtFF7K3Gi0ginImzG5as8Qb/RZSsrMtRjinN84LfKb0J97JwIqMGeCZxn6zuiiCUTVAg8erSEXQq5tRfeZG98L0nWQcVX7QD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hHtLGW3k; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c7869704so3527553f8f.2
        for <linux-hyperv@vger.kernel.org>; Mon, 17 Nov 2025 10:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763403108; x=1764007908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkXn2uf2BmayOa330xtRb/7V5dbi6gpwEITJjIUhIzo=;
        b=hHtLGW3k92cOOb73mCpjPZ3mmvetgZBtDXyLluAqL8sZ3UdRC7P9A6XMnTkuwy1ADQ
         5lKs/Zp0166Gd2R+f4K382mgZoZGocmipZGDUf7ocLmSpLTp9cgFml9YRU9ZLGpGPikl
         Nbk1PodKoZM3ubMKzh8+1JfspwAPZf+pSSJZdzhV8Cdrfrk8HQ8YDFQA5NMCdNBJm0gK
         I+4m8VhuebJlJHzJBzd1LkUu7GyxNwtAXEuPBwvG543RNAhNWRdR5z2pSdKJWJ0KY6ZA
         SBOuM3syn5FtI4kMLwlBh665N9cIJzsZ3hdFA4eiFopUsmMgci2d1A5oTsOIKh3k3B1F
         SLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763403108; x=1764007908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkXn2uf2BmayOa330xtRb/7V5dbi6gpwEITJjIUhIzo=;
        b=hcfIOae/qAzupR4QaDYfpOMm9Oluul5sqcK3vjelrTxJjpAz4JoGj4AY0pK04NmRzL
         zV3IljDBFmujEeM04n47M3dJOHa/ps0J2Losn3oy+q+MNSIHlWnOBVlCROC2xOJlNhQY
         dn+W9k8xLWNko2ys/xsePfIl8yGjV869x5PxbkWiYWVHzkZ/zI0I8kmH9bHxlZa6jUeZ
         ItuTYGDnABA6RApHrGRerWKiwIR8tD9IQcBkmQ+c8NAoV1jTnQd/fmYa5DNvxMaywjsO
         t+GZanqwsdYvZciNhHgH8DOQrwkYxLA9jT79/EZutGZ/5JHMTk0QtZZmVYSLiLdbvX+U
         yl0A==
X-Forwarded-Encrypted: i=1; AJvYcCWLOJa2QK/Czu5zwUpH944gtLuIW4Ifbr09VYI1Z2qmqIPd5L4t5oIYj6JIsPenQAJ7iQbYswWbSYO8pA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8F0WlDL29Sqggocs8MwdWV7CqrUxhgQXbn/GmQwNzE9ikIVVL
	HR3KjZl8fMurYbnjrGP02vuk5cfi3/PmjIdcPWw2+00TyOj2V37heSQDnCWPQpVKFCk=
X-Gm-Gg: ASbGncsaPCsg02oEhMnIDJwWsAtmxWOutHrigp8QF7OAlvDVdXfbquYMwfw+jhVNmya
	2lUsSnlltUs626py0hUgh+d6Pd5kI2do755PXWLs+kjxX8Z2qk2w6xmVfov86MiqrPKXz7LlZuy
	zbO5o8sIIECXzNM9vlGf6k9Has/K5gTlMhq2XVOiucf+nr1l5muIp6LNYNwFgRiEZAQK6SyhPlU
	cUBg08kI3xrHhb0xhcL2pJuSwHdbMDQPTnQD02qqSvO4Xj53zP51jWlWgZ/pq8GfrnJ2nlR5FmV
	E7LJVj/Z+BSrrhQV7HJLnSBHIKI4Y6Pxvn8pniq1+H8evuLQze0+3W8aF/t17g/EksDBj7WPhph
	HsUdkVgGNiKwdDDKQtAwwyer2UfFKuFXLjsH01OzbsryqglFiHRVcd8eM28CNUW+UGBTgC+mm3z
	n3jvcEdJyINs4Kypg4bs37w05dbj4=
X-Google-Smtp-Source: AGHT+IGHhEQCJaDM/zq/AjpMPqh+c0eOHsOAgGFxOiztiCVkL4Xu6fzfIxyiuFP74BN85ttgdB3SyQ==
X-Received: by 2002:a05:6000:1849:b0:42b:394a:9e0 with SMTP id ffacd0b85a97d-42b5937879bmr12050647f8f.32.1763403108288;
        Mon, 17 Nov 2025 10:11:48 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42b53f0b617sm27141178f8f.31.2025.11.17.10.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 10:11:47 -0800 (PST)
Date: Mon, 17 Nov 2025 21:11:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ally Heev <allyheev@gmail.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH v3] net: ethernet: fix uninitialized
 pointers with free attribute
Message-ID: <aRtlYIZ2XOQKMGd_@stanley.mountain>
References: <20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
 <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
 <aRsfBDC3Y8OHOnOl@stanley.mountain>
 <dd88462f-19cb-4fde-b1f0-5caf7e6c6ce6@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd88462f-19cb-4fde-b1f0-5caf7e6c6ce6@intel.com>

On Mon, Nov 17, 2025 at 03:37:30PM +0100, Alexander Lobakin wrote:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Date: Mon, 17 Nov 2025 16:11:32 +0300
> 
> > On Thu, Nov 06, 2025 at 03:07:26PM +0100, Alexander Lobakin wrote:
> >>> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> >>> index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b3809d715e40bb290e40c4aa 100644
> >>> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> >>> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> >>> @@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
> >>>  			 struct ice_parser_profile *prof, enum ice_block blk)
> >>>  {
> >>>  	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
> >>> -	struct ice_flow_prof_params *params __free(kfree);
> >>>  	u8 fv_words = hw->blk[blk].es.fvw;
> >>>  	int status;
> >>>  	int i, idx;
> >>>  
> >>> -	params = kzalloc(sizeof(*params), GFP_KERNEL);
> >>> +	struct ice_flow_prof_params *params __free(kfree) =
> >>> +		kzalloc(sizeof(*params), GFP_KERNEL);
> >>
> >> Please don't do it that way. It's not C++ with RAII and
> >> declare-where-you-use.
> >> Just leave the variable declarations where they are, but initialize them
> >> with `= NULL`.
> >>
> >> Variable declarations must be in one block and sorted from the longest
> >> to the shortest.
> >>
> > 
> > These days, with __free the trend is to say yes this is RAII and we
> > should declare it where you use it.  I personally don't have a strong
> 
> Sorta, but we can't "declare it where you use it" since we don't allow
> declaration-after-statement in the kernel.

That changed when we merged cleanup.h.  It is allowed now.  I still don't
like to declare variables anywhere unless it's a __free() variable and I
think almost everyone else agrees.  The only subsystem which I know that
completely moved to declaring variables willy-nilly was bcachefs.

regards,
dan carpenter


