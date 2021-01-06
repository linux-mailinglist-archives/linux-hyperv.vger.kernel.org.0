Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903912EB8C5
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 05:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbhAFEBr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Jan 2021 23:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAFEBr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Jan 2021 23:01:47 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBEBC06134C
        for <linux-hyperv@vger.kernel.org>; Tue,  5 Jan 2021 20:01:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id h186so986352pfe.0
        for <linux-hyperv@vger.kernel.org>; Tue, 05 Jan 2021 20:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=CDgibIGXx39qkCOF0q2QH8v6fPooZvCUIVM2zf27fD8=;
        b=qeoLhCDdXACcug+hWouvb2ciMc3eHVILMGrnA8aGNRjXEUVpnkgmmf29b+rpyCOfOI
         SWbz0/sxc2jXJXQLnWmOu+eUV1c6fI5JQRd9a71uhe3WIvGndWIk7LBSDrQ2nADW6w0i
         7saucOgvrLgJKeXXVWrROvjw6iXlL0XZyB8pXvcZWZHomh5BblelDvmuD2wvnSK/Fuks
         4C62SCiZB42VmW+Z7D8+QuvZtsefOk+ViBd9wOljAw0oHc6BZtluOunbBEQpe0A1u0BO
         DIDB7WPtklVmYgAyyh4wIEnrbFkJKUcYpzjCLy/X1HhST27fO8CDQIRRIYxjZMWOM1D7
         eewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=CDgibIGXx39qkCOF0q2QH8v6fPooZvCUIVM2zf27fD8=;
        b=ZSDmH+iBZKF6Qv21yHuvUCjqbhU+rDNPqEIR486N/bGAzrJumqOQfIR4aadj/mqlQZ
         FVuEMeKkuhSl2Al+mTBHQMVSNy+aGlGBnc1VjvIFzj410+qb0Y2k3uhnGsbZ91RXIe1i
         aIGwr822uOTj21PqzWq20GmSAg6MX56scFKqcQ4HUf1gcXab8qs/pCpa9eEOApIvFEyJ
         L2gy36S394DgV/FmsT4J0Z1alnKZA+snvsnr4gzGia4l3SIi7Wt1tv0fvN+VUDIXUKd/
         TX5FUhxtbUHPo9SoFhf9pVLi3+d4jy3m/9GyNIJXAItWteUAhqPENJVgLzk+5dgRbD+L
         fZdQ==
X-Gm-Message-State: AOAM533ctYdbd40XIyr2oIDxz/misIoKVc7Z62sst8z0S3yeX4dXCBvJ
        aT3KThq7NeUNUbt+iWb9P0M=
X-Google-Smtp-Source: ABdhPJxqgLRO5Mr15qaTpgdAQYSSIU2N9VASQCQTOX7qOcwJOzPyXYrSiSyhVR4YnH18RM9+k7pxLg==
X-Received: by 2002:aa7:9afb:0:b029:19e:45d8:b102 with SMTP id y27-20020aa79afb0000b029019e45d8b102mr1977624pfp.48.1609905666975;
        Tue, 05 Jan 2021 20:01:06 -0800 (PST)
Received: from [192.168.1.8] (50-47-106-83.evrt.wa.frontiernet.net. [50.47.106.83])
        by smtp.gmail.com with ESMTPSA id 17sm647234pgy.53.2021.01.05.20.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 20:01:05 -0800 (PST)
Message-ID: <84e09e65b831ba6d3017a6ca9be039005b24e793.camel@gmail.com>
Subject: Re: [PATCH 1/2] drm/hyperv: Add DRM driver for hyperv synthetic
 video device
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, Wei Hu <weh@microsoft.com>,
        Tang Shaofeng <shaofeng.tang@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        dri-devel@lists.freedesktop.org,
        Michael Kelley <mikelley@microsoft.com>,
        Sam Ravnborg <sam@ravnborg.org>
Date:   Tue, 05 Jan 2021 20:01:04 -0800
In-Reply-To: <8ff4bd88-6e98-3db5-232d-98ce2c370cd1@suse.de>
References: <20210102060336.832866-1-drawat.floss@gmail.com>
         <2b49fcd2-38f7-dae5-2992-721a8bd142a2@suse.de>
         <4f7818f99734c0912325e1f3b6b80cb2a04df3ef.camel@gmail.com>
         <ec340e8e-6386-d582-c93b-0a35c60f9dca@suse.de>
         <20210105110438.zhy22zzqfgbnonos@sirius.home.kraxel.org>
         <8ff4bd88-6e98-3db5-232d-98ce2c370cd1@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 2021-01-05 at 12:30 +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 05.01.21 um 12:04 schrieb Gerd Hoffmann:
> >    Hi,
> > 
> > > > It's not possible to do page flip with this virtual device. The
> > > > call to
> > > > SYNTHVID_VRAM_LOCATION is only honoured once. So unfortunately
> > > > need to
> > > > use SHMEM helpers.
> > > 
> > > I was thinking about using struct
> > > video_output_situation.vram_offset; in
> > > case you want to tinker with that. There's a comment in the patch
> > > that
> > > vram_offset should always be 0. But this comment seems incorrect
> > > for devices
> > > with more than one output.
> > 
> > Where does the comment come from?  fbdev drivers support a single
> > framebuffer only so for a fbdev driver it makes sense to set the
> > offset
> > to 0 unconditionally.  With drm you probably can handle things
> > differently ...
> 
> I cannot find it in hyperv_fb.c; it must have gotten introduced here.
> 
> Only one display is supported by this DRM driver, so the comment is 
> correct. In the future, having support for multiple displays might be
> an 
> option.
> 
> 

Beside that offset should be 0, another problem is that
SYNTHVID_SITUATION_UPDATE will cause the whole screen to flicker (I
suppose this call is more for changing resolution), so can't really use
this for page-flip.


