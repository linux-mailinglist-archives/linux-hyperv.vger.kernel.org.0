Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998062D7CAF
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Dec 2020 18:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389467AbgLKRUJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Dec 2020 12:20:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54690 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394924AbgLKRT5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Dec 2020 12:19:57 -0500
Received: by mail-wm1-f65.google.com with SMTP id d3so8169299wmb.4;
        Fri, 11 Dec 2020 09:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JzXe05XkrDGolHgowsn6PdKPuoe5hbd5ZtmqMuR980I=;
        b=a5K1p/SwcdsOJcQ9BGC/J+7B97TXv+d9+E9jxLpMdIOHUJcz1W9alfvIHMhSDVAvCv
         guZ20Wem7VG/eAaz2vWK/JmMhpAXeDJ+OM5qkNscqgE4IeXqhZHTVnShnXwHpl7Spexq
         eEBLP/H+DdN67vZngAM5BwxGN1S0UwoRDM48pbSIA81r9pHf82CpXbcypmFtABGvkzs5
         cP0/yHUR0JFQA48gjBqZb+0rk/bP6uiyKEFoBilgBlLYhAOZj5meeOy9a3anJu2YznYx
         4llSEGjXnnoI9aVelcWiP/IAYNILOmFRKF/icc9CNU/3UYrqDXiU5mZyvNT2Ed9MTaD5
         2TXQ==
X-Gm-Message-State: AOAM531yE4d/WzBgLlDf50IOLK0ptXN2A9KXD/KLT5OrdBDHHURso6Zz
        s8gGX+M8w2/sWqEN/H64AUQy8jrdzO8=
X-Google-Smtp-Source: ABdhPJxiqRw+PW7X1JdqzbYIWLfUsiQL+4tkHKTjJuEsQdpQUTg3XfMMRO7Ip0MEtcQustmqb3HCxQ==
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr14397383wmh.88.1607707155496;
        Fri, 11 Dec 2020 09:19:15 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z2sm16439735wml.23.2020.12.11.09.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 09:19:14 -0800 (PST)
Date:   Fri, 11 Dec 2020 17:19:13 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Revert "scsi: storvsc: Validate length of incoming
 packet in storvsc_on_channel_callback()"
Message-ID: <20201211171913.w4cwph5irkmlgqlf@liuwe-devbox-debian-v2>
References: <20201211131404.21359-1-parri.andrea@gmail.com>
 <20201211140137.taqjndaqjjo25srj@liuwe-devbox-debian-v2>
 <yq1pn3go0ft.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1pn3go0ft.fsf@ca-mkp.ca.oracle.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Dec 11, 2020 at 09:59:34AM -0500, Martin K. Petersen wrote:
> 
> Wei,
> 
> > Sorry for the last minute patch. We would very like this goes into
> > 5.10 if possible; otherwise Linux 5.10 is going to be broken on
> > Hyper-V.  :-(
> 
> Applied to 5.10/scsi-fixes.

Thanks Martin.
