Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D841A201531
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Jun 2020 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394487AbgFSQTX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Jun 2020 12:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390746AbgFSQSY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Jun 2020 12:18:24 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80721C0613EE;
        Fri, 19 Jun 2020 09:18:24 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t21so8014919edr.12;
        Fri, 19 Jun 2020 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66DS8cscbOrDDtJFLg4/sv1VZqtWg1mGwXAH3gSwi2w=;
        b=UbD+cIfdXzYr/rZ1ERd4wfsIKJNa31io9WaMhqcq486ayiJe6jrTzIOa8ZTqLBisSd
         O71oFljVG3Eay64l/d/sIbanCPTJaFIoCrl1bq8dG5d+itJ+cuOHhYsaMs4o7iVTQes+
         NoslFybuA1UG8oJHUI53ftDzGHYJfJyDVVuzLXwo08spKLkJEdy+BYNgEURXCUb9B9FU
         AXzNZPtQcjh7CKn9HzBCqt7i4HZjV/eQ8uRdrZBy8cGCauzoYTrPeRrpGM927qkldbfe
         gZBduiPXxgKCOY2exRYSsMYn4s4QgtyMmRpDU6jpk2zV7w606zrJbbIUVvwTn6psGmoH
         +Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66DS8cscbOrDDtJFLg4/sv1VZqtWg1mGwXAH3gSwi2w=;
        b=bOC8jvOMtpz4hGKEoh80T3jylRBi5Q1OMfqPIme3tqcP5XNIZgrPWk/SSGIlhn0a1c
         eeHFeFH4n0wSs/+jTMTnYB30yUM/kLnl+wSbKXeZz8Qrsi969WvK5ov1Y8FY0M7yo5GG
         6c4zxgVpxvNn1AEXeBn0p7ez/omaOmSICpHQ5wqFTURoa4ztqtL1ustY8XB3hzCCtIEf
         TIHdathNsfDGSbltl8LzW9QGkZD++mmxvMicX5Aj+fV34c1T4At1joGcO1zaBHW9C0e6
         4lykitI1kHqYTG/rnNK5aRFrxqYG0WuPbY6O3lxyRwK4LBZRPUtHT3425DMPPPtghDZU
         p14A==
X-Gm-Message-State: AOAM530LxiVGzrBBNvzzYwaoWFSlSvLYYUrhsMt3N20BUuhgm+eizaqq
        smACdVpsDiyjvHCAVj9xGm4=
X-Google-Smtp-Source: ABdhPJw3hCgZvXVzgIXNddGxi5BWYv8GmLBWoEx0wtBhcQNXiKk07b1OLPTwdmsMcQdazl7s0yf5xA==
X-Received: by 2002:a50:d55c:: with SMTP id f28mr3987366edj.87.1592583502476;
        Fri, 19 Jun 2020 09:18:22 -0700 (PDT)
Received: from andrea (ip-213-220-210-175.net.upcbroadband.cz. [213.220.210.175])
        by smtp.gmail.com with ESMTPSA id jt16sm5059932ejb.57.2020.06.19.09.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:18:22 -0700 (PDT)
Date:   Fri, 19 Jun 2020 18:18:13 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 7/8] scsi: storvsc: Introduce the per-storvsc_device
 spinlock
Message-ID: <20200619161813.GA1596681@andrea>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200617164642.37393-8-parri.andrea@gmail.com>
 <20200619160136.2r34bdu26hxixv7l@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619160136.2r34bdu26hxixv7l@liuwe-devbox-debian-v2>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jun 19, 2020 at 04:01:36PM +0000, Wei Liu wrote:
> Cc SCSI maintainers
> 
> This patch should go via the hyperv tree because a later patch is
> dependent on it. It requires and ack from SCSI maintainers though.

Right.  Sorry for the Cc: omission...  ;-/

SCSI maintainers, please let me know if you prefer me to send you a new
series with this patch (7/8) and the later/dependent hyperv patch (8/8).

(1-6/8 of this series are hyperv-specific only and have been applied to
the hyperv tree, so this would only 7-8/8 of this series out.)

Thanks,

  Andrea
