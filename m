Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1568392BD5
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 May 2021 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhE0Kay (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 May 2021 06:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236093AbhE0Kav (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 May 2021 06:30:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92A3C061574
        for <linux-hyperv@vger.kernel.org>; Thu, 27 May 2021 03:29:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q25so255574pfn.1
        for <linux-hyperv@vger.kernel.org>; Thu, 27 May 2021 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=l9Q90fGTdqRxJNMjjDNRJNKXXHuzzfmziiIyuJGZz28=;
        b=JeDwCmVrF3cAIe20Y8v6csEq5BP6OQZYLyX2uLt8xF47jzF3YQrzU2T60otwqwKHRY
         xzWTyKoT7+oRFNq2L0ki5TZ+KCSEWggcaM/w8dowB7A+SW3pBqDJbhemrDIWHyY0Ev5l
         Z8+yGGtYWFgVvKOC3MM7htXC2fqB/wBG1XAU9p65MEnhpmMBgx/1/Agso7R9sAOFOBEI
         obf94KsleYAfQKpG1oYGQwaIYMzMbsn19XVXV3yJkURHvu2yQBsIDldadZZbrFyAcNJB
         nWUcBy6s0YSbmk4hyi18VDbeRPJWKlUMp2NlqVCZQGicV4Kg2aij6lbwynrmbQFMTxZ8
         /4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=l9Q90fGTdqRxJNMjjDNRJNKXXHuzzfmziiIyuJGZz28=;
        b=cE50/+e7Zc1UiaS1qJ4FDWtbRQojOaUhxYA1mEfFXC/ULNHVw/lRTGcchDhh3gpKjR
         uNzQSn//cgw2arjXZ3NRDmeXDx5eth+WV74o5dN1cXX33cOAjdfaQjZ4ZtuGQ8A+Z7Yo
         8FzR7ct/quuaFisfaOrVkWVhzr3zyJYaYDtqOs+UHKTbufynrYIOUfXGznF3FBae6WrS
         SjgC+uKVzmTIa6QjNV9rCHTA+YS/259S+SVoyWo7hjaPomIT0T2p3bPry/btANJUgO9N
         rW0Y8Lq7d0jEctvpV1bYrf1bk180edNu+7NtsZstiDEkoNMfNz0xmMsBTL+oJ/c3NZ8s
         XntQ==
X-Gm-Message-State: AOAM531IROxuA6RWVNsIjJqG1+r4lVhHSpOp/Y7jMGmaW4RlPGbAOCyx
        YjXB7LX1Bem67m5yLuoZ413OEYPfQXYjvA==
X-Google-Smtp-Source: ABdhPJxK7y+PEYXzQxry0qkGQCIv/0DYD+75J4NqB+1EoPFJfEj36dUTXakLlyW5WGrvzYedegKDDQ==
X-Received: by 2002:a65:564c:: with SMTP id m12mr3152032pgs.298.1622111354308;
        Thu, 27 May 2021 03:29:14 -0700 (PDT)
Received: from [192.168.1.8] ([50.47.106.83])
        by smtp.gmail.com with ESMTPSA id n8sm1580788pfu.111.2021.05.27.03.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 03:29:13 -0700 (PDT)
Message-ID: <0e449c3d589d8999ea5ee392f2b72b437f65a604.camel@gmail.com>
Subject: Re: [PATCH v5 1/3] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Dexuan Cui <decui@microsoft.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     Michael Kelley <mikelley@microsoft.com>
Date:   Thu, 27 May 2021 03:29:13 -0700
In-Reply-To: <b093d480-c3f1-f2f7-1107-60195c0bea0c@suse.de>
References: <20210519163739.1312-1-drawat.floss@gmail.com>
         <MW2PR2101MB08920209B00F7692FA83BBD0BF2A9@MW2PR2101MB0892.namprd21.prod.outlook.com>
         <b093d480-c3f1-f2f7-1107-60195c0bea0c@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 2021-05-26 at 21:42 +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 20.05.21 um 07:41 schrieb Dexuan Cui:
> > > From: Deepak Rawat <drawat.floss@gmail.com>
> > > Sent: Wednesday, May 19, 2021 9:38 AM
> > > ...
> > > +static int hyperv_vmbus_suspend(struct hv_device *hdev)
> > > +{
> > > +       struct drm_device *dev = hv_get_drvdata(hdev);
> > > +       int ret;
> > > +
> > > +       ret = drm_mode_config_helper_suspend(dev);
> > 
> > If 'ret' is not zero, return immediately?
> > 
> > > +
> > > +       vmbus_close(hdev->channel);
> > > +
> > > +       return ret;
> > > +}
> > 
> > 
> > > +MODULE_DESCRIPTION("DRM driver for hyperv synthetic video
> > > device");
> > 
> > s/hyperv/Hyper-V ?
> > 
> 
> Maybe let's fix these points and then get the driver merged.

Hi Thomas, sure. This was on my list to fix before merge. One patch is
missing ack/review, so it would be nice if that also is reviewed.

Thanks,
Deepak

> 
> Best regards
> Thomas
> 


