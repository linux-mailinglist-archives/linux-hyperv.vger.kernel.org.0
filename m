Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8454C387AC0
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 May 2021 16:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349786AbhEROLi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 May 2021 10:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349703AbhEROLh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 May 2021 10:11:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA99CC061573
        for <linux-hyperv@vger.kernel.org>; Tue, 18 May 2021 07:10:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 22so7094218pfv.11
        for <linux-hyperv@vger.kernel.org>; Tue, 18 May 2021 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5PhvFpEj5Jv7/tDgkVZZmBwcTpOnJPEafYIx+5Yo9cI=;
        b=mX6HuOXSfPlMEEadR6ZHmHfxZRAlVGb+niymAS9WNN9C3aHb7qYLgo8M9yTb4Roz/K
         FjNWUrcBBPExTuPA/QkvNh7e2udQUCGvWGPbsfyYVMg5+CEkRD/GC+ukRr6tP8f/nZj/
         4juBngXAOOOOwDN6rf44wgvpEB9k+TqyNBeoF4DpNEnErF2EpW7fVFMSqZaofMBPe8Va
         Wod3U9Tg/8B7IEJmeVsmomvbvMMIZDkf2W8rLsi8lVIYkiSgKfZTWy6N4zpwZeuUzy0V
         eb8winNCYw9cJE6nvq+yYC3mn63TCeEGRZbE22BtlmXNiPQWH58qcsR+eLtyZb2oH5tI
         QpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5PhvFpEj5Jv7/tDgkVZZmBwcTpOnJPEafYIx+5Yo9cI=;
        b=YmYBwjS+HBt+SZLJJ/V6yjT/i8m79GWgy3p1K3FzHlG/QpX+YNWS5GqSLstwMblwvb
         v2Q5TEyotmqr04HY8CTQUOqxgEsodoh4DssLQMZzB9ZZOJ9cFQ0yREfS+F5SdQjcZMKs
         LP4AofEydZbs/75HYsIk1uAH8KAB0gwJRUI38ofUZvutaLPHuaTUpiEua380w3v9Yhbe
         CKa/cN+hCjtVwcAe/OKUm2ykk7CZCW8fqVpboiZY1u6twTOpiO9/6BZ0JC15q57T91x7
         L0KJDppYES44QRc4XuqXHyybIf3i0HPQflc2mCjkkk74vF0PCIfqMJHMq+j2QmUXOgQv
         F+ew==
X-Gm-Message-State: AOAM532Gd2uzgWAph35o1GAKetZL/QiBO8ENOXKqUCljjXrgc7yD0G9I
        WOT+1/0RqvfCCeXyWef6YJ8=
X-Google-Smtp-Source: ABdhPJyVPoDyYqj9WEhMDiY51xY2lTstkQbDILJDhuOl1up3PKlTW2ewSw+s/+94CFv0eEpjlNpZ2w==
X-Received: by 2002:a63:d941:: with SMTP id e1mr5246152pgj.124.1621347019328;
        Tue, 18 May 2021 07:10:19 -0700 (PDT)
Received: from [192.168.1.7] ([223.177.234.226])
        by smtp.gmail.com with ESMTPSA id r10sm9354552pjm.20.2021.05.18.07.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:10:18 -0700 (PDT)
Message-ID: <0e61f1a6c099a4eea6d51fe31de8c0870a70a70c.camel@gmail.com>
Subject: Re: [PATCH v4 1/3] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Date:   Tue, 18 May 2021 07:10:19 -0700
In-Reply-To: <3c7966c8-8985-e5f1-464c-90bc6544dc74@suse.de>
References: <20210517115922.8033-1-drawat.floss@gmail.com>
         <3c7966c8-8985-e5f1-464c-90bc6544dc74@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > +
> > +static struct pci_driver hyperv_pci_driver = {
> > +       .name =         KBUILD_MODNAME,
> > +       .id_table =     hyperv_pci_tbl,
> > +       .probe =        hyperv_pci_probe,
> > +       .remove =       hyperv_pci_remove,
> > +};
> 
> The PCI code doesn't do anything. Do you need this for gen1 to work 
> corretly. If so, there should at least be a short comment. Why don't
> you 
> call hyperv_setup_gen1() in the PCI probe function?
> 
> 

Thank you very much Thomas for the review. Yes, this is needed for gen1
to work. Regarding why hyperv_setup_gen1() is not called from PCI
probe, this is to maintain consistency with hyperv_fb and also
hv_driver probe method is called irrespective of gen1 or gen2. I will
add a comment explaining this.

Deepak

