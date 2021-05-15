Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD83819C0
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 May 2021 18:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhEOQKt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 15 May 2021 12:10:49 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40865 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhEOQKs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 15 May 2021 12:10:48 -0400
Received: by mail-wm1-f42.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so395798wmf.5;
        Sat, 15 May 2021 09:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aSGQJagwvk6PPII7IdB5b+OW9KihpKvzZJPLLXU8/AA=;
        b=RKxP7Vtmn5cP1LVtEG6rsY1e3iRtfu8muTUKW1IUr+ebE+S3w6gX6nhFZkukQ0/wjq
         VMRfXN0oiSrxD8L7653ghBkN8ZlF+TOdQX745k2nX7D7ZkzQYY12MiyJIrwQWx+LmP5Q
         92GFbk2luNmN79jpq08W7SUNGQSR6+UL+MdpXtQWB1k5nSw9FeIBjwp3WkNmjNjQU8tJ
         anyF1rTzQuE30CPg27wp8B5AEJGhtmLURCC+9VJYNhS/nH9OEddB+CN0FjFd5sQxKiVP
         7iayf/n40gHK1bcKrD06kNHbKX4AAEsYhUsHx2m4flZvynqrRbSMQtbA2cj3gR9lhx4K
         Jh6w==
X-Gm-Message-State: AOAM532LlhfsYtxGaQv/SyhpkAFzwUdcRRWhngQ2ha3w5Ig3Ioh3wDd1
        TyTJwBUIRsG/fKkqrJMUkr4=
X-Google-Smtp-Source: ABdhPJyrztD03NAPUEXoCPIjoFrPVVZIm7WBpX37/50MGqp10Odx39R1l3bx0sr234Mhp47bElqxhA==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr15138368wmc.131.1621094974315;
        Sat, 15 May 2021 09:09:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n6sm736281wmq.34.2021.05.15.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 09:09:33 -0700 (PDT)
Date:   Sat, 15 May 2021 16:09:32 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        decui@microsoft.com, gregkh@linuxfoundation.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] uio_hv_generic: Fix a memory leak in error handling
 paths
Message-ID: <20210515160932.v4inlp5xlzokmmel@liuwe-devbox-debian-v2>
References: <4fdaff557deef6f0475d02ba7922ddbaa1ab08a6.1620544055.git.christophe.jaillet@wanadoo.fr>
 <20210511095227.ggrl3z6otjanwffz@liuwe-devbox-debian-v2>
 <f0dca7cf-c737-0f06-34aa-e4759826a974@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0dca7cf-c737-0f06-34aa-e4759826a974@wanadoo.fr>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, May 11, 2021 at 08:18:23PM +0200, Christophe JAILLET wrote:
> Le 11/05/2021 à 11:52, Wei Liu a écrit :
> > > Before commit cdfa835c6e5e, the 'vfree' were done unconditionally
> > > in 'hv_uio_cleanup()'.
> > > So, another way for fixing the potential leak is to modify
> > > 'hv_uio_cleanup()' and revert to the previous behavior.
> > > 
> > 
> > I think this is cleaner.
> 
> Agreed

Stephen, ping?

If I don't hear back from you, I think Christophe should move ahead with
modifying hv_uio_cleanup.

Wei.
