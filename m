Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C0A215B80
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2020 18:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgGFQJd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Jul 2020 12:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbgGFQJd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Jul 2020 12:09:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07114C061755;
        Mon,  6 Jul 2020 09:09:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d10so15513401pls.5;
        Mon, 06 Jul 2020 09:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=akHPfGbpeWWmSpHVQKn1tnbebShxLvGv7K6Kjm81A8M=;
        b=HGV7npdrgjq5gaIFVA3exiVrM/5aMGcO5vcMdoZ0cIZcsMUqvUBWYmZba4f9WwIltH
         10SQbGWrzZfvTnTARgizLch8PcpiPjhIPLIKBBO3zJMs/KRxYC0Udv5zRiNVnGm23bmJ
         opoAjQzt0ed8U7NUkOE3QfzOwUc8fJlPvgdl66J7Qpk3NPjQC0AJexuZhKVaDhUXMJtq
         L4HEwtq86fF9Wq7opWWpe42n98+5mh3In5ybbxtB16GR9TcB9Ke8u7iEmW3iYVwfn8vT
         EqfDKZS5/J/fNOEezyHa5V+JLu1kSn1wA9VYyyvTVpDmR7urpgD+Fl2XSD67Fp9EVN/L
         A9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=akHPfGbpeWWmSpHVQKn1tnbebShxLvGv7K6Kjm81A8M=;
        b=mH1KrTMGw9dq+3pOf3mJx9VUpP0SLmwyemzYDYe8HGQB1u3M8bexUbRorGdirN1Bp2
         bZqEJaCztqP+I65W7T0qJUxWMh+U1YevHK/MVW5/l9g987ybQx+SJSO0wOI6tndyklcc
         mhyOZlcr7AH6JJ4I15rDaMziKqxqHsbYc2V5Xq3xkmn/8BaXP+UCgF8lN0y13FJfu4yt
         gZuui4VbatWJVQrkaWgshlNbC7Zwkauri6Wsh0HTiSRZJzA+mEJDHlDyL/Rxf4TSSslB
         znw+oHFSAwj8aQGI/tu3A9IvOyPY2i636hBtlKXnvdd4W61pStY4PnIG5hdcw9gbHSfI
         +xSA==
X-Gm-Message-State: AOAM530RRaeuFWB9Q7L0/jMTu4HCIvsNsK7BP3d4oaC5MPaKDBSYZ1qT
        TL/NAn2TDmdYA0rM3wFeEijWwGK0
X-Google-Smtp-Source: ABdhPJw1wlqbgNW5zgCh+aqklnbOf/4U2UnqnfOOQqwp/+KKhaXyjGUNq367SHVr5oHohpOuy+mVsQ==
X-Received: by 2002:a17:90a:3f88:: with SMTP id m8mr16758pjc.26.1594051772595;
        Mon, 06 Jul 2020 09:09:32 -0700 (PDT)
Received: from localhost.localdomain ([131.107.159.194])
        by smtp.gmail.com with ESMTPSA id k92sm19255904pje.30.2020.07.06.09.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 09:09:32 -0700 (PDT)
From:   Andres Beltran <lkmlabelt@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com, parri.andrea@gmail.com,
        skarade@microsoft.com, Andres Beltran <lkmlabelt@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: storvsc: Add validation for untrusted Hyper-V values
Date:   Mon,  6 Jul 2020 12:09:28 -0400
Message-Id: <20200706160928.53049-1-lkmlabelt@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For additional robustness in the face of Hyper-V errors or malicious
behavior, validate all values that originate from packets that
Hyper-V has sent to the guest. Ensure that invalid values cannot
cause data being copied out of the bounds of the source buffer
when calling memcpy. Ensure that outgoing packets do not have any
leftover guest memory that has not been zeroed out.

Cc: James E.J. Bottomley <jejb@linux.ibm.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
---
 drivers/scsi/storvsc_drv.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 6d2df1f0fe6d..5fcc555a67a4 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1133,6 +1133,10 @@ static void storvsc_command_completion(struct storvsc_cmd_request *cmd_request,
 			data_transfer_length = 0;
 	}
 
+	/* Validate data_transfer_length (from Hyper-V) */
+	if (data_transfer_length > cmd_request->payload->range.len)
+		data_transfer_length = cmd_request->payload->range.len;
+
 	scsi_set_resid(scmnd,
 		cmd_request->payload->range.len - data_transfer_length);
 
@@ -1173,6 +1177,11 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 	/* Copy over the status...etc */
 	stor_pkt->vm_srb.scsi_status = vstor_packet->vm_srb.scsi_status;
 	stor_pkt->vm_srb.srb_status = vstor_packet->vm_srb.srb_status;
+
+	/* Validate sense_info_length (from Hyper-V) */
+	if (vstor_packet->vm_srb.sense_info_length > sense_buffer_size)
+		vstor_packet->vm_srb.sense_info_length = sense_buffer_size;
+
 	stor_pkt->vm_srb.sense_info_length =
 	vstor_packet->vm_srb.sense_info_length;
 
@@ -1623,6 +1632,7 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 
 	request = &stor_device->reset_request;
 	vstor_packet = &request->vstor_packet;
+	memset(vstor_packet, 0, sizeof(struct vstor_packet));
 
 	init_completion(&request->wait_event);
 
@@ -1736,6 +1746,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 	/* Setup the cmd request */
 	cmd_request->cmd = scmnd;
 
+	memset(&cmd_request->vstor_packet, 0, sizeof(struct vstor_packet));
 	vm_srb = &cmd_request->vstor_packet.vm_srb;
 	vm_srb->win8_extension.time_out_value = 60;
 
-- 
2.25.1

