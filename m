Return-Path: <linux-hyperv+bounces-7621-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B894CC64516
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 14:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B9C334A3D7
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A993191D5;
	Mon, 17 Nov 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLVj8uYa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8C732F754
	for <linux-hyperv@vger.kernel.org>; Mon, 17 Nov 2025 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385101; cv=none; b=WfpcFBfi/6Fn4yk3S/qStGl9eHR5/UhmhXQAILEQ/2b8HYhsWcg551RxXQvUjPiL9JDRYn0qC2/wrbcbacRaqaMhaf3zONqJzIxQ2gn33opatOe3IDeNoMDx8dHW4t6xz0ijPk/68Ji4v6UoZSJtP+xzAls9o4AN8beBDRSYT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385101; c=relaxed/simple;
	bh=h38v3zpCAfMH+LpTc6wSw688KR9quyXTFOdnu5vd3ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvcGbPwnLu7fliD9SsDG5HjsQq43NqsIr+1bqnDVcUSJrkUubErKWZvvjFMxxZdTTZZQKUEyAQr77D/GcVNmGWABMR3vMK9B0qMTK3V5jVgs3UpwiVpktBuLFn5qBOXgDssjVIAtVWnS81DaDZmjzR0O8AYXiOaWKi/FPhJAPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLVj8uYa; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477a219db05so6384615e9.2
        for <linux-hyperv@vger.kernel.org>; Mon, 17 Nov 2025 05:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763385097; x=1763989897; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01cC7ySHWhCFyMvXlU1Mt2SGt2tFSxfshKiVMAheuoI=;
        b=yLVj8uYaSCjrb72FiilVrWr/H2KRDyuSdftsRh+jw5/BjrJAimz9B8Z8ZRPkh94c+2
         QFJqJKGGon/Bd/W6B7NNUPzBxKfwdPwLYn+HQxlUyJw+xmRJn7FMRqkeP1ozaUuC6x3I
         QuXmfmi8YFPxnH7jxyOcwQ94X20/89r3GonEhH6ReH+gt44g1AUgezz58AlQ2joi393A
         HQd2OYZDct2/mJnCXXZz/EWZH7f1dVSr2nla5VQuqxZYKK0TaneyStTqgk44kWYkQKnV
         DR1F0+ndJ/rXRpy6dn2rwgMZViDYMH5U46JNh+a4aTBW1xKkVrtO/6ShxNC/LOlWqnJs
         e6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763385097; x=1763989897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01cC7ySHWhCFyMvXlU1Mt2SGt2tFSxfshKiVMAheuoI=;
        b=UiukQWe6zXvlLVtk5wFShVGl4lshXgrfAEkTgDA7KmA6I18nBoxLuZsOAGMzlHl/vq
         8x51SsmCQ5G1DjHEQsIuG2449QFkg/+uPU6SWn8WdodtoHmShLmltn7eyQ+LE7oQKHLl
         r+FzQcGvshnA3lyuttKXG5nBPTyUnHaysjMonECpgkv1ORMJkXb4cGbrs7/GyLFvqwKA
         XiE+BO/2vdTVNm0pDi++Y+6AMNUoHZti2RF6C3fbr6o28kcZZfVdsgPqCwXgjhkOUOiK
         +ttPrkNqFf60qR4HcdKjtEIzvK8ej9pZ+zXazIyoZdFDtf48w6EojvWAPgJcZbeQYN0M
         Kkwg==
X-Forwarded-Encrypted: i=1; AJvYcCVNrUoa9YhssmQwuptB6FbkQFGOEqlTwmGqIVLbbqkNl/642rS8aMmasZPTqpJfqnlRP5gMP0HtbdP874s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2cZ2aCqEMANbgLXTP08FxQt1xPj08pGYJ7OimBw7+G8KoXSmm
	5fGqN1qNHXqaFxf3iJtwkoVW1lqinUVYxlkYMpQnK9zgiwD1pUJ8pwn+xSBAvR0wYy0=
X-Gm-Gg: ASbGncsRcqtFdYESEEcHpQe3NDDL9d+vJUoDhcw/R0UYTNgh+PsXwNHfFc/0WAcCTOl
	zn5s4b1CKrjNV0MH1hodwtfYGstKooS7jaaAfhUN1AEcdSBEwPVes9hq2P0l96xIunIsJVs6vXV
	fABivPRgHtNNizVCHncmkGN7qvNQIhjnHyoi1l13pogjI6hM932rnjC5RW6gaSfO0Cy9Wl1rY5V
	UPPDHoS37VZPWl91mARiD+p2Mqz1a30lwu8YJpl3clrcNTZCQIaYfGAw9//Jynp1O25JVslMeab
	5c2DOAYlQp/f+Kd6aIVaIFwKkfC8Ey+Qh5gAhl7olxXPl0+wwCHkUP5KDKK32lSzpKt4rhjj0E2
	3AN24hxd6ZUyasv6T72qz7VO3Clorf+NJyAHnutdzxWhRV+nFpuZGbQ7C6egd27IrbnPphky2W8
	+Dzss+LQ==
X-Google-Smtp-Source: AGHT+IHBC+9FsxtsdSHIREVrp/G6htztuNX/oUndRO09FTt+ZBKnna4hH64IsewtZZFfCyMd6Zo6+A==
X-Received: by 2002:a05:600c:a43:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4778fe59f2amr105544325e9.6.1763385097412;
        Mon, 17 Nov 2025 05:11:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4779973ddcfsm130108955e9.15.2025.11.17.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 05:11:36 -0800 (PST)
Date: Mon, 17 Nov 2025 16:11:32 +0300
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
Message-ID: <aRsfBDC3Y8OHOnOl@stanley.mountain>
References: <20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
 <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>

On Thu, Nov 06, 2025 at 03:07:26PM +0100, Alexander Lobakin wrote:
> > diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> > index 6d5c939dc8a515c252cd2b77d155b69fa264ee92..3590dacf3ee57879b3809d715e40bb290e40c4aa 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> > @@ -1573,12 +1573,13 @@ ice_flow_set_parser_prof(struct ice_hw *hw, u16 dest_vsi, u16 fdir_vsi,
> >  			 struct ice_parser_profile *prof, enum ice_block blk)
> >  {
> >  	u64 id = find_first_bit(prof->ptypes, ICE_FLOW_PTYPE_MAX);
> > -	struct ice_flow_prof_params *params __free(kfree);
> >  	u8 fv_words = hw->blk[blk].es.fvw;
> >  	int status;
> >  	int i, idx;
> >  
> > -	params = kzalloc(sizeof(*params), GFP_KERNEL);
> > +	struct ice_flow_prof_params *params __free(kfree) =
> > +		kzalloc(sizeof(*params), GFP_KERNEL);
> 
> Please don't do it that way. It's not C++ with RAII and
> declare-where-you-use.
> Just leave the variable declarations where they are, but initialize them
> with `= NULL`.
> 
> Variable declarations must be in one block and sorted from the longest
> to the shortest.
> 

These days, with __free the trend is to say yes this is RAII and we
should declare it where you use it.  I personally don't have a strong
opinion on this either way, but other maintainers do and will NAK the
`= NULL` approach.

The documentation says you should do it that way and avoid the `= NULL`
as well.  The issue is with lock ordering.  It's a FILO ordering, so if
we require a specific unlock order then declaring variables at the top
could mess things up.

The counter argument is that if you declare a variable after a goto
then that's undefined behavior as well.  Clang will detect that bug so
it be detected before it hits actual users.

regards,
dan carpenter


