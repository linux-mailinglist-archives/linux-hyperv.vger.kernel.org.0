Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12792422FCA
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Oct 2021 20:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhJESQX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Oct 2021 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhJESQX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Oct 2021 14:16:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159FFC061749;
        Tue,  5 Oct 2021 11:14:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id p11so2139705edy.10;
        Tue, 05 Oct 2021 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qrVDa6iqwbI1N1i5Vvsk2q6J4SqfjK9r6QKza8oCivI=;
        b=AA0eXZM6Nho5oZvo6al2SeGKlZfJensqta3LehDMmebtXUXElVigfZhvJJE3M9f+yA
         cQQ2Z7QGwIO3ZVvRLLaWezv6d1Mnr3W3EYvfkfZEwJKZYFPBAGM1jKP3NonsiiI51srq
         4Rsu09nvxptF67f10at7blY211KI5vSmsJwCYo2xABCS3xaZfp+xFO+82Ug301IP4/Eq
         MZ8YGC0IUXmz/YBMZTOlGE+76tJWtcyd/bjCfkwcgWJAnxwL5lTeoFOvffKATZp+1iVc
         weiaPXIYbqOCi4yaXitOID2JZbDZU2UvjiSWQUzLLBKSG/e4qaOTYuVyDAT0ElxmiTQM
         yhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qrVDa6iqwbI1N1i5Vvsk2q6J4SqfjK9r6QKza8oCivI=;
        b=nB3NC1DcS/gi8wvucN+YtQbY0mxH+8C2TAlKvvBlOohvWzVrddYYMYrlGYeikzavPw
         ePBuy2btgsliME1iWB1PLhFj8rrjKHSjJuG2yrNQXJkpiuWSTafTALv+MzpRcDj7tuwf
         EXdErrTsS3gHf5+Y9gqZ9qmmZGDX6kP8/vM/Tv5FCYnylmGmgAYQ4PTSPu7Q6vF+qOuF
         O7TQO2yzjR3AXVbNndDlZrecugvd6RlKdjroMqqZRDXd8dDiENKiRf0ojdfdNPvIyrzR
         APXyF2NeSY4C3U56xvxXaYmiwNtqsrQYxp0rIMFtoPa7w/FpPs5wTAnkdOPDZPwIArNX
         tYOQ==
X-Gm-Message-State: AOAM533AVT5zu0uSjdI7mNKn1NPsj5N/o25naO3ejT/nbt69sncpvYmu
        fyhpRf2+7en4G43TpaV9/ek=
X-Google-Smtp-Source: ABdhPJxnZiAFCgH3mNtRtBZf9s+olbhESF2EJDUaPjin0mTkfZiEUY4Vd94Go43dgya325nYhMt1Nw==
X-Received: by 2002:a17:906:e011:: with SMTP id cu17mr23108770ejb.244.1633457670478;
        Tue, 05 Oct 2021 11:14:30 -0700 (PDT)
Received: from anparri (host-79-49-65-228.retail.telecomitalia.it. [79.49.65.228])
        by smtp.gmail.com with ESMTPSA id e7sm7259482edv.39.2021.10.05.11.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 11:14:29 -0700 (PDT)
Date:   Tue, 5 Oct 2021 20:14:21 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <20211005181421.GA1714@anparri>
References: <20211005114103.3411-1-parri.andrea@gmail.com>
 <MWHPR21MB15935C9A0C33A858AFF1A825D7AF9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15935C9A0C33A858AFF1A825D7AF9@MWHPR21MB1593.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> > @@ -292,6 +292,9 @@ struct vmstorage_protocol_version {
> >  #define STORAGE_CHANNEL_REMOVABLE_FLAG		0x1
> >  #define STORAGE_CHANNEL_EMULATED_IDE_FLAG	0x2
> > 
> > +/* Lower bound on the size of unsolicited packets with ID of 0 */
> > +#define VSTOR_MIN_UNSOL_PKT_SIZE		48
> > +
> 
> I know you have determined experimentally that Hyper-V sends
> unsolicited packets with the above length, so the idea is to validate
> that the guest actually gets packets at least that big.  But I wonder if
> we should think about this slightly differently.
> 
> The goal is for the storvsc driver to protect itself against bad or
> malicious messages from Hyper-V.  For the unsolicited messages, the
> only field that this storvsc driver needs to access is the
> vstor_packet->operation field.

Eh, this is one piece of information I was looking for...  ;-)


>So an alternate approach is to set
> the minimum length as small as possible while ensuring that field is valid.

The fact is, I'm not sure how to do it for unsolicited messages.
Current code ensures/checks != COMPLETE_IO.  Your comment above
and code audit suggest that we should add a check != FCHBA_DATA.
I saw ENUMERATE_BUS messages, code only using their "operation".

And, again, this is only based on current code/observations...

So, maybe you mean something like this (on top of this patch)?

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 349c1071a98d4..8fedac3c7597a 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -292,9 +292,6 @@ struct vmstorage_protocol_version {
 #define STORAGE_CHANNEL_REMOVABLE_FLAG		0x1
 #define STORAGE_CHANNEL_EMULATED_IDE_FLAG	0x2
 
-/* Lower bound on the size of unsolicited packets with ID of 0 */
-#define VSTOR_MIN_UNSOL_PKT_SIZE		48
-
 struct vstor_packet {
 	/* Requested operation type */
 	enum vstor_packet_operation operation;
@@ -1291,7 +1288,7 @@ static void storvsc_on_channel_callback(void *context)
 		u32 pktlen = hv_pkt_datalen(desc);
 		u64 rqst_id = desc->trans_id;
 		u32 minlen = rqst_id ? sizeof(struct vstor_packet) -
-			stor_device->vmscsi_size_delta : VSTOR_MIN_UNSOL_PKT_SIZE;
+			stor_device->vmscsi_size_delta : sizeof(enum vstor_packet_operation);
 
 		if (pktlen < minlen) {
 			dev_err(&device->device,
@@ -1315,7 +1312,8 @@ static void storvsc_on_channel_callback(void *context)
 				 * storvsc_on_io_completion() with a guest memory address that is
 				 * zero if Hyper-V were to construct and send such a bogus packet.
 				 */
-				if (packet->operation == VSTOR_OPERATION_COMPLETE_IO) {
+				if (packet->operation == VSTOR_OPERATION_COMPLETE_IO ||
+				    packet->operation == VSTOR_OPERATION_FCHBA_DATA) {
 					dev_err(&device->device, "Invalid packet with ID of 0\n");
 					continue;
 				}

Thanks,
  Andrea

