Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EABC423F87
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Oct 2021 15:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhJFNl3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Oct 2021 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbhJFNl2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Oct 2021 09:41:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC66C061749;
        Wed,  6 Oct 2021 06:39:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b8so10172167edk.2;
        Wed, 06 Oct 2021 06:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZXUegjCUcjZM3YT3AwpKd2XzjXbHH263VlRYRLyBqyI=;
        b=jg2ahWTWJvxDuJvvK9KKKXtaOoz55Ep8CjDvuYwSlUbrgfakL8YL0wF6hNOVT3bDcZ
         vxg0kHknPWi/ItFdt+bDgo0FMnwv8HUI4KmHNH/9wwxMRDeIjih8qT6er8YzlPkKjzRg
         6TcIiZGSMpH8h5QMl106xVSmPDaJBeSyydxvd9QTcxQQgIAwLhl6l/50f8AwGUWVOqE3
         HYz5sM1GcyXBNjcYppAA7C0kmaf2DO2UJcuOaZnyBOi/SgNzO0aOvEiFBMEOUeUYaG8X
         QkoiVm2IQkPMakJFANmeNIMMfq8BsyAe6HSZ+z+Rn3m1i8KI0u00WZqUlBBgo7+ammB3
         ptvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZXUegjCUcjZM3YT3AwpKd2XzjXbHH263VlRYRLyBqyI=;
        b=sfj5m2K7M9EA+0ziqEc6l5+9gxKo7EFGgtD4uoNAUkGJPPRjj+eI6Su1g0zeGfDz3W
         KgYElJDA4R4uBA4fKW3ZApuImQ6d+1oRVzMhsJgNtxLmhoa4cn5GneWihWMtXV41Li6/
         HkusAs2bWMT8CicBA2Z5O9e58E+lxz+tWBsZlzehepQ0ZDM67BRmOCJdx48PNh2YjsuW
         DM5cPy4s3eC57grqMEnxzPvOMlfhZob9/BYj+aX8OOHrY9ZU6v/YXgSqQ/ffZwkMvdj6
         oQkqFVgsCCN5Kcco8bRtNzQ4EOw3Q9Odgjm494jtagdRs3mmaDr5TnR+Ztp+htaCGfEh
         sbNw==
X-Gm-Message-State: AOAM530qlBVXvszC3AVXkDNOGzu1izr7ltw7dVs4o5H5sJB5/hYESuGr
        AfbAXZ1nwPm36mrH48j9RaM=
X-Google-Smtp-Source: ABdhPJylgbVU4nz7Vo+3S35MhLIotNdSRC4SKRQn4RFQNTyauUB7OrGiZbDkYEze26W83o7NUNx3zw==
X-Received: by 2002:a50:eb9a:: with SMTP id y26mr24086544edr.186.1633527568128;
        Wed, 06 Oct 2021 06:39:28 -0700 (PDT)
Received: from anparri (host-79-49-65-228.retail.telecomitalia.it. [79.49.65.228])
        by smtp.gmail.com with ESMTPSA id r6sm5173259edd.89.2021.10.06.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 06:39:27 -0700 (PDT)
Date:   Wed, 6 Oct 2021 15:39:09 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     Long Li <longli@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] scsi: storvsc: Fix validation for unsolicited incoming
 packets
Message-ID: <20211006133909.GA22926@anparri>
References: <20211005114103.3411-1-parri.andrea@gmail.com>
 <MWHPR21MB15935C9A0C33A858AFF1A825D7AF9@MWHPR21MB1593.namprd21.prod.outlook.com>
 <20211005181421.GA1714@anparri>
 <MWHPR21MB15933E46ABC6DC0AA5DD0A5AD7AF9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15933E46ABC6DC0AA5DD0A5AD7AF9@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > > I know you have determined experimentally that Hyper-V sends
> > > unsolicited packets with the above length, so the idea is to validate
> > > that the guest actually gets packets at least that big.  But I wonder if
> > > we should think about this slightly differently.
> > >
> > > The goal is for the storvsc driver to protect itself against bad or
> > > malicious messages from Hyper-V.  For the unsolicited messages, the
> > > only field that this storvsc driver needs to access is the
> > > vstor_packet->operation field.
> > 
> > Eh, this is one piece of information I was looking for...  ;-)
> 
> I'm just looking at the code in storvsc_on_receive().   storvsc_on_receive()
> itself looks at the "operation" field, but for the REMOVE_DEVICE and
> ENUMERATE_BUS operations, you can see that the rest of the vstor_packet
> is ignored and is not passed to any called functions.
> 
> > 
> > 
> > >So an alternate approach is to set
> > > the minimum length as small as possible while ensuring that field is valid.
> > 
> > The fact is, I'm not sure how to do it for unsolicited messages.
> > Current code ensures/checks != COMPLETE_IO.  Your comment above
> > and code audit suggest that we should add a check != FCHBA_DATA.
> > I saw ENUMERATE_BUS messages, code only using their "operation".
> 
> I'm not completely sure about FCHBA_DATA.  That message does not
> seem to be unsolicited, as the guest sends out a message of that type in 
> storvsc_channel_init() using storvsc_execute_vstor_op().  So any received
> messages of that type are presumably in response to the guest request,
> and will get handled via the test for rqst_id == VMBUS_RQST_INIT.  Long 
> Li could probably confirm.  So if Hyper-V did send a FCHBA_DATA
> packet with rqst_id of 0, it would seem to be appropriate to reject
> it.
> 
> > 
> > And, again, this is only based on current code/observations...
> > 
> > So, maybe you mean something like this (on top of this patch)?
> 
> Yes, with a comment to explain what's going on. :-)

My (current) best guess is here:

  https://lkml.kernel.org/r/20211006132026.4089-1-parri.andrea@gmail.com

Thanks,
  Andrea
