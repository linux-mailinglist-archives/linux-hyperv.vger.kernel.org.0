Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B58431DCF6
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Feb 2021 17:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhBQQLG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Feb 2021 11:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhBQQKt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Feb 2021 11:10:49 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3D7C061574
        for <linux-hyperv@vger.kernel.org>; Wed, 17 Feb 2021 08:10:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id fy5so1730735pjb.5
        for <linux-hyperv@vger.kernel.org>; Wed, 17 Feb 2021 08:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=twn7H61LwoasXev40PwLZ/u/tW+/PTLk2sNN/MHHJFM=;
        b=sI43mdtN9/WupK0RaIZVzokjDtXExKNt0RsvM1sZrEOG905NdrUNTWYlFplavSmYBT
         DI+aOOE/g5PdB+Vs/MBXYbdzEdoRK6tGKwL04c9e+Pr5acz8VnIIEw6+n0TCdQqjoTEH
         00XLMmPARctOGwMYFsR/AqghKqgQfrae/k+5Q2Hk39cpq23zPW6mTUMPzHZbHwwmui2J
         ygmeb7I0CJrHM/J5zH74+VwETy7CM7yGjpp6aoh5T/BPSMI1NWN3ND8ERbZfwiJCbfEZ
         C4EvyiC/+q90paXXx90gaDtENU3+EfKGh0ov73I+5EpLqmwJYG+cGiBkwAQbLfwb6oDr
         Rqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=twn7H61LwoasXev40PwLZ/u/tW+/PTLk2sNN/MHHJFM=;
        b=NsOk++m5PiFp+g2Jk/++UVDVEV5+g4Dbg5bkbBbQpxnbNNxVtAEsf1o0gh630+3r2w
         LBlCI/XGlq4szmdKFd8CzXoTeusr8jGSF3G+w11yZdTlKrg9c/VHYjcyZWVbtVxdZmie
         LlOVRDR41d8A/mKFCWBN2WoTm2hEV/VxZCvqFNi0MjuZNnDnTIC+y585HuwnoOao7LcE
         CGQ8UnHTZNtTvGVozPukVxSUAHyLVelcWPnYOvhCDnaPWfn0Knjk+Adk5Gp3ikCToCXi
         IdrH+eMGrMxbR2zZdfjPSGvp7AHXX3eNArfSmydX7pOgnMAf4vMROrjBCGA3MWgWvkay
         3vOg==
X-Gm-Message-State: AOAM533rcfTDcWCGEvTk58OphH7M9s+3QCNRVz0fX1PF9lR5WnG3jddc
        8CnaRNGzhdZdFa9cRclI7sU=
X-Google-Smtp-Source: ABdhPJwd0B2BYwZK7t1opg93RJ/2yPdvJ/QA/ll57kwYHLt+i9zoW6kJpz3SilXUpZ4Jsv4ux7FMTg==
X-Received: by 2002:a17:90a:77c4:: with SMTP id e4mr9529684pjs.185.1613578209165;
        Wed, 17 Feb 2021 08:10:09 -0800 (PST)
Received: from [192.168.1.8] ([50.47.106.83])
        by smtp.gmail.com with ESMTPSA id f2sm3339169pfk.63.2021.02.17.08.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 08:10:08 -0800 (PST)
Message-ID: <68ec72635c83f5e984e19b3227ab2c5d8d2b4892.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Wei Hu <weh@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
Date:   Wed, 17 Feb 2021 08:10:08 -0800
In-Reply-To: <RTH7ReroyaiuwV4na7jvXgaUVHZydoksEf6N1fD_5baGD33auW8TAqtfhOE9WquzDFooXhdGQLZfd5CxgIDRbq7OoM67dtutwHp1SrNRLVA=@emersion.fr>
References: <20210216003959.802492-1-drawat.floss@gmail.com>
         <RTH7ReroyaiuwV4na7jvXgaUVHZydoksEf6N1fD_5baGD33auW8TAqtfhOE9WquzDFooXhdGQLZfd5CxgIDRbq7OoM67dtutwHp1SrNRLVA=@emersion.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 2021-02-17 at 13:22 +0000, Simon Ser wrote:
> On Tuesday, February 16th, 2021 at 1:39 AM, Deepak Rawat <
> drawat.floss@gmail.com> wrote:
> 
> > +static int hyperv_conn_init(struct hyperv_drm_device *hv)
> > +{
> > +       drm_connector_helper_add(&hv->connector,
> > &hyperv_connector_helper_funcs);
> > +       return drm_connector_init(&hv->dev, &hv->connector,
> > +                                 &hyperv_connector_funcs,
> > +                                 DRM_MODE_CONNECTOR_VGA);
> > +}
> 
> Nit: shouldn't this be DRM_MODE_CONNECTOR_Virtual?

Thanks Simon for the review, I think it make sense to use
DRM_MODE_CONNECTOR_Virtual.



