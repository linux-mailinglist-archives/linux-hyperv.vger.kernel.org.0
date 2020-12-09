Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159B12D4349
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Dec 2020 14:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbgLINcb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Dec 2020 08:32:31 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34680 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732040AbgLINcb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Dec 2020 08:32:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id k14so1775810wrn.1;
        Wed, 09 Dec 2020 05:32:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9PtDfW/fN1jLsypWqYWwwBwZf0lR76Ldk40gi59pMdo=;
        b=sMWfov+x8jmPCsQqGLg5ZlvYl0o0la+T3Ge6yRK13u8yn+2YsRdA69y8fG6IKv1Zam
         LXxtESBzIEmElNlz64ZWckV7BkOv7ai6t8rp+SCSdNEOtGWsHUbq243ET6UNc2nXYcod
         BWO86QgHlWC2+kj1nb/UkhXLZWrVV8itQI5qjVJSwOSAj8aoI+BJgfJrFvlCHtTr4a0N
         eLJhXIFqnBAthGZ4UwGmPYWhEPmD4Ht1s6EfflHZapX/OPx/AXXUbKOFmGWUXQ7vqt8t
         TX8U+nwF/mGfq1ZwdokJlnsDYr6NctFV87HK3HU1MDWYwFkSF+a3oVRD/MvBaeaseThu
         zwOQ==
X-Gm-Message-State: AOAM531RKiqL16MwQwm2ze+JhuBUGg/dyGQCZ8Cla1y+mAzOeyucpynx
        Ui7hXHJPchOec3c2ihEc22o=
X-Google-Smtp-Source: ABdhPJzgA9POoPvraoSpQ+3TYDe9Ond5pY/EKttmqTmFrmzJ5aL050+glxM75oFsMItIzggbDr9y2w==
X-Received: by 2002:adf:a34d:: with SMTP id d13mr2818997wrb.194.1607520708604;
        Wed, 09 Dec 2020 05:31:48 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z21sm3343249wmk.20.2020.12.09.05.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:31:48 -0800 (PST)
Date:   Wed, 9 Dec 2020 13:31:46 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] scsi: Fix possible buffer overflows in
 storvsc_queuecommand
Message-ID: <20201209133146.yskq5rnxpdaiqhrc@liuwe-devbox-debian-v2>
References: <20201208131918.31534-1-ruc_zhangxiaohui@163.com>
 <MW2PR2101MB10523F50AA4497A9E116FBC0D7CD1@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <56cde2c6.bb9.176451a57d7.Coremail.ruc_zhangxiaohui@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56cde2c6.bb9.176451a57d7.Coremail.ruc_zhangxiaohui@163.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Dec 09, 2020 at 09:25:23AM +0800, Xiaohui Zhang wrote:
> 
> 
> 
> At 2020-12-09 01:52:42, "Michael Kelley" <mikelley@microsoft.com> wrote:
> >From: Xiaohui Zhang <ruc_zhangxiaohui@163.com>  Sent: Tuesday, December 8, 2020 5:19 AM
> >> 
> >> From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> >> 
> >> storvsc_queuecommand() calls memcpy() without checking
> >> the destination size may trigger a buffer overflower,
> >> which a local user could use to cause denial of service
> >> or the execution of arbitrary code.
> >> Fix it by putting the length check before calling memcpy().
> >> 
> >> Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
> >> ---
> >>  drivers/scsi/storvsc_drv.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> >> index 0c65fbd41..09b60a4c0 100644
> >> --- a/drivers/scsi/storvsc_drv.c
> >> +++ b/drivers/scsi/storvsc_drv.c
> >> @@ -1729,6 +1729,8 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct
> >> scsi_cmnd *scmnd)
> >> 
> >>  	vm_srb->cdb_length = scmnd->cmd_len;
> >> 
> >> +	if (vm_srb->cdb_length > STORVSC_MAX_CMD_LEN)
> >> +		vm_srb->cdb_length = STORVSC_MAX_CMD_LEN;
> >>  	memcpy(vm_srb->cdb, scmnd->cmnd, vm_srb->cdb_length);
> >> 
> >>  	sgl = (struct scatterlist *)scsi_sglist(scmnd);
> >> --
> >> 2.17.1
> >
> >At first glance, this new test isn't necessary.  storvsc_queuecommand() gets
> >called from scsi_dispatch_cmd(), where just before the queuecommand function
> >is called, the cmd_len field is checked against the maximum command length
> >defined for the SCSI controller.  In the case of storvsc, that maximum command
> >length is STORVSC_MAX_CMD_LEN as set in storvsc_probe().  There's a comment
> >in scsi_dispatch_cmd() that covers this exact case.
> >
> >You are correct that we need to make sure there's no buffer overflow.  Are
> >you seeing any other path where storvsc_queuecommand() could be called
> 
> >without the cmd_len being checked?
> 
> 
> Hello, maybe storvsc_queuecommand() could be called without the cmd_len 
> being checked in scsi_send_eh_cmnd().

In that case, a better approach is to fix the SCSI layer instead of
individual drivers, right? Storvsc can't be the only one that is
affected by this issue.

Truncating the command solves the buffer overflow issue but it doesn't
make sense to issue a truncated command to the controller.

Wei.
