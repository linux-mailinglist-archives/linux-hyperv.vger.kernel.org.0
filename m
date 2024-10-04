Return-Path: <linux-hyperv+bounces-3119-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B798FEC3
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 10:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802CB283EB1
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Oct 2024 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9597F13D248;
	Fri,  4 Oct 2024 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJc8xgmA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1167617758;
	Fri,  4 Oct 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029656; cv=none; b=LnLQLDiF3zKvB++8BowzTn+TA+OHtxnIaUo1++YWL2qDbpam9HmFUD+BZ0H6w3TGr5/LRieR+/3lVF0NaewADLpdYQTWXx9J2HlBCC1Ws/LaSlzfL56/L30Jmkh4119s5pc9NZ3jHxdBBbu+VCp7cdY/BLtvh0uAgpBvCcXoPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029656; c=relaxed/simple;
	bh=q4PAR/bsCH8kTxyaCKWzUsqMcHzx79O2jdCM4zIg87M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryG9bE+7ywKlCw0uYNIV+u2JuUtLPAnki8aBsqK+mTmRh9jPkT1IaBdEVP+x1A4MfZPxJuiKiI8jacsbcRAS35UMej+aYO+FjIyqw2H1+wysxbeuRtlhzRyD64tIWEtRTNKan9cAsQgZAbXZaCdcnN1pzzBX4gQX/FKntn0j3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJc8xgmA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b90984971so19579855ad.3;
        Fri, 04 Oct 2024 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728029654; x=1728634454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DuscQM2ywf/wxvdnQNbAatV0h7OSv8/sdUQy5XOgb0E=;
        b=XJc8xgmARsqlqjrODG94hcbTFoXzQ86HzvlXDPHxAMr9f2gybemux72+XH/JVCJW4+
         69HJCIz7DzMHVCWOUFNMeMTxjZ5dMHJQOaxOUBpw6iSNSQhPxnXD25dG5ZLJtdWd4Lfm
         He+1FfpiMm/6qELk15Vei17mRWMuBotaaZycPvAKbzkcgbl1dYye2Obsnz/8pRCL6r9R
         ZcddheWAPS9WL4EAdstRh+wXKLFeelTS17Eh1tr/whVAXlX1jiIJEmmxGG8Ug49IzA1n
         d1HPIR0GDJDIHpewoDECpJKVyUVSohB0UxV6K0S2bikRGkWL0YdDfxtZD2R714H1e5zi
         BYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029654; x=1728634454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuscQM2ywf/wxvdnQNbAatV0h7OSv8/sdUQy5XOgb0E=;
        b=crmWl0bZD8+bRQcyBNnXKIDO04Ut/BKPQ2ViYw4H7dhHg4rw8xk8DzP91/RJweB2s/
         /WyFlgBidVfMPQ52b1ULydvLmL9OQF1PQdErrI3G86c3Mv6gcx/VfbTt3FCO/buoScVs
         AnmDPL+Th/14Pn0V+d3wK00+pmOQnZ5bu3Nn2HL7WxHNIp59wfP+OmBciFMqS6+kf4G0
         bYrzLakaghuyl4u8Vlqv5OO2nAbBOHMVn/eCI299dmmLJ5wzc2GmAjR9QRTTHQLhVlUK
         FaJSy0/98IZ8ncGQUXq+DJ5RLCmakTTteBr84WDDiTRGX+WmYIWKB/AdDCJYybT9d4LT
         FVBw==
X-Forwarded-Encrypted: i=1; AJvYcCUc3eVFsie/wO/5cTrFpFaVqCZ4WTjj+wVnzOAziX2tGHbdqm5BYCt791ruZVb5qFZKOjidzwKuYOz0T7w=@vger.kernel.org, AJvYcCUj9Y5GSWnk0pnSjWrHocghiYLeOXJCH6LDZEjrlUFYzZHUFQgBcBUeNCNjfubaNirrtUk7PIDMO5v7qqg=@vger.kernel.org, AJvYcCWG2bDjQCnWdxF1u5dJpNtiBldVwT3mY/n4oXcttOlDzSir/IGZHYPZiAitaicaf8l0KB1ZKAM7LJ4=@vger.kernel.org, AJvYcCWVuUKZoGtN+lpH/T1W87TD8hBj65tSVU/nT4dCfsFMAn/CG1jNMANW07Ua4nmqb7a22XYV+RHM6TxEcB33@vger.kernel.org
X-Gm-Message-State: AOJu0YwK7Xyr8/CwWf0xwvnYl/vFCaOV5pT1pCsqXL2MFNR64rz4AdGj
	YLuJ24JxZGt2k0RmaOceQMdLkqh/8OsjPr8og8plSm2Ip1P8rrcm
X-Google-Smtp-Source: AGHT+IEXJAN7uexvG8eW9NSUkSEj0cmuMH+7sVFlViKxFTYCfEv4crw0YuaHe/Iz1dI50TQUEJk4Gw==
X-Received: by 2002:a17:90a:744a:b0:2e0:8bad:6ea4 with SMTP id 98e67ed59e1d1-2e1e631e4abmr2095634a91.29.1728029654178;
        Fri, 04 Oct 2024 01:14:14 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1b2:add:2542:c298])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85c99c3sm927256a91.23.2024.10.04.01.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:14:13 -0700 (PDT)
Date: Fri, 4 Oct 2024 01:14:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	jikos@kernel.org, bentiss@kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	ernis@microsoft.com, rafael@kernel.org, pavel@ucw.cz,
	lenb@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] Revert "Input: hyperv-keyboard - register as a
 wakeup source"
Message-ID: <Zv-j0qtWXsDz4Hah@google.com>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
 <1726176470-13133-3-git-send-email-ernis@linux.microsoft.com>
 <ZvIx85NmYB/HzKtI@csail.mit.edu>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvIx85NmYB/HzKtI@csail.mit.edu>

On Tue, Sep 24, 2024 at 03:28:51AM +0000, Srivatsa S. Bhat wrote:
> [+linux-pm, Rafael, Len, Pavel]
> 
> On Thu, Sep 12, 2024 at 02:27:49PM -0700, Erni Sri Satya Vennela wrote:
> > This reverts commit 62238f3aadc9bc56da70100e19ec61b9f8d72a5f.
> > 
> > Remove keyboard as wakeup source since Suspend-to-Idle feature
> > is disabled.
> > 
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > ---
> >  drivers/input/serio/hyperv-keyboard.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> > 
> > diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> > index 31d9dacd2fd1..b42c546636bf 100644
> > --- a/drivers/input/serio/hyperv-keyboard.c
> > +++ b/drivers/input/serio/hyperv-keyboard.c
> > @@ -162,15 +162,6 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
> >  			serio_interrupt(kbd_dev->hv_serio, scan_code, 0);
> >  		}
> >  		spin_unlock_irqrestore(&kbd_dev->lock, flags);
> > -
> > -		/*
> > -		 * Only trigger a wakeup on key down, otherwise
> > -		 * "echo freeze > /sys/power/state" can't really enter the
> > -		 * state because the Enter-UP can trigger a wakeup at once.
> > -		 */
> > -		if (!(info & IS_BREAK))
> > -			pm_wakeup_hard_event(&hv_dev->device);
> > -
> >  		break;
> >  
> >  	default:
> > @@ -356,9 +347,6 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
> >  		goto err_close_vmbus;
> >  
> >  	serio_register_port(kbd_dev->hv_serio);
> > -
> > -	device_init_wakeup(&hv_dev->device, true);

If you do not want the keyboard to be a wakeup source by default maybe
change this to:

	device_set_wakeup_capable(&hv_dev->device, true);

and leave the rest of the driver alone?

Same for the HID change.

Thanks.

-- 
Dmitry

