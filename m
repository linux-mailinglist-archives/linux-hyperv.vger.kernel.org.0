Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554F72043D9
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Jun 2020 00:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbgFVWnj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 22 Jun 2020 18:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731363AbgFVWnX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A973C061573
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Jun 2020 15:43:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a45so369394pje.1
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Jun 2020 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=7sJlh8mTqMMVGGRGPmGdis+KAhpQkSnkGxPpFCRucz4=;
        b=o2xCtanL8ODfPn/UTNBOWQQB+TAT2girD+UigaTEp4DeTAsmFfePy80P1nqC30ZVzj
         oaA9t8AGW3OcSMnqr/5q4OtOXtvOwpxTxNcuaFtHU/cG56s+rljiIfhsg3G4UC/tRe62
         GXw+nYjVmsZFIpFldfOxI4LrZwlIVe/Mk4wyTZQJ8BMEH42j7Zw1ZH15WMP1mgGHb1Rm
         UDSA1xFGd47qvGJo1/HKlNQDow7cu5uB6amm5usNvN9zw837i3FvpncqyJs+NkI5JMUG
         pvVS6Z3zXQeWzNO2/2UdV+yHJvdzJprBJKIj6T398ZpVTmmuQf1PcYA9UulSumkp2nph
         QZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=7sJlh8mTqMMVGGRGPmGdis+KAhpQkSnkGxPpFCRucz4=;
        b=gG8eEf7uNdFElU/h5j1t+dI/hewW9Nh1NZ3uS+3HS3yplJF2C1Netp33C8Cs7/JEqn
         SrEM8DHBCbKOZGgAzyIINzuNYWi8Ha+jJQ4IehHIp0zaWS/2mk8LGDYxizbDAgMbB13t
         9QBZtKElo2XHgPyis36fAJCjn4ubk3jf37lm9op0ovnxjRwFPOw1MgCx30yaeMNViTIt
         7iDae0+i8aYPeAS/e02hK08AmBRLlTaVcMO8BR3Xae8CA4xqIh+4fYJvcmfvRaWwq/ct
         Nrj4lW4zCZaEdOpSlDE8cRuq9ci4oRRzOuRsKpbZ6JB+MhdFo25ULtSbJDi3Wd39M7ur
         bALw==
X-Gm-Message-State: AOAM533M8rMYB3cMq7EhlAzy5OvJamwSiw+BYXS9Om6zSaQpc1L/qADH
        T7Uka6+c1xxE9SJfq4zp5do=
X-Google-Smtp-Source: ABdhPJyKgbIcdaiIqEDpP8cteo6S4Uuv5X/JU2P+m1Ri/0bY1KmTfSh3ekbKQm5bkE8cTsFe9QD9yA==
X-Received: by 2002:a17:90a:1aa2:: with SMTP id p31mr21506738pjp.227.1592865802790;
        Mon, 22 Jun 2020 15:43:22 -0700 (PDT)
Received: from arch ([2601:600:9500:4390::d3ee])
        by smtp.gmail.com with ESMTPSA id n9sm508927pjj.23.2020.06.22.15.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:43:22 -0700 (PDT)
Message-ID: <af5ebef18bcce1272ab1e02daa0b04cc4284ed9e.camel@gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        David Airlie <airlied@linux.ie>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Jork Loeser <jloeser@microsoft.com>,
        Wei Hu <weh@microsoft.com>, K Y Srinivasan <kys@microsoft.com>
Date:   Mon, 22 Jun 2020 15:43:21 -0700
In-Reply-To: <20200622151913.GA655276@ravnborg.org>
References: <20200622110623.113546-1-drawat.floss@gmail.com>
         <20200622110623.113546-2-drawat.floss@gmail.com>
         <20200622151913.GA655276@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


> 
> Just a buch of drive-by comments while browsing the code.
> In general code looks good, especialyl for a v1.
> 
> There is a few places that triggers warnings with checkpatch --strict
> Most looks like things that should be fixed.
> 
> 

Thanks Sam for the review. Will take care of the suggestions in next
iteration.

Response inlined below:


> > +struct pipe_msg_hdr {
> > +	u32 type;
> > +	u32 size; /* size of message after this field */
> > +} __packed;
> > +
> > +struct hvd_screen_info {
> > +	u16 width;
> > +	u16 height;
> > +} __packed;
> > +
> > +struct synthvid_msg_hdr {
> > +	u32 type;
> > +	u32 size;  /* size of this header + payload after this field*/
> Add space before closing "*/"
> 
> I wonder what is the difference between what is considered a message
> and
> what is considered payload in the above comments.
> Maybe that just because I do not know this stuff at all and the
> comment
> can be ignored.

message = struct pipe_msg_hdr + struct synthvid_msg_hdr + payload

Will try to make it more clear.

> 
> > +} __packed;
> > +
> > +struct synthvid_version_req {
> > +	u32 version;
> > +} __packed;
> > +
> > +struct synthvid_version_resp {
> > +	u32 version;
> > +	u8 is_accepted;
> > +	u8 max_video_outputs;
> > +} __packed;
> > +
> > +struct synthvid_vram_location {
> > +	u64 user_ctx;
> > +	u8 is_vram_gpa_specified;
> > +	u64 vram_gpa;
> > +} __packed;
> Not an alignmnet friendly layout - but I guess the layout is fixed.
> Same goes in otther places.

Yes nothing can be done for this.


> 
> > +static int synthvid_update_situation(struct hv_device *hdev, u8
> > active, u32 bpp,
> > +				     u32 w, u32 h, u32 pitch)
> > +{
> > +	struct synthvid_msg msg;
> 
> Sometimes synthvid_msg is hv->init_buf.
> Sometimes a local variable.
> I wonder why there is a difference.

When a reply is expected, hv->init_buf should be used, though I haven't
verified this. Just kept the same logic as in framebuffer driver.



