Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A5D39BE7E
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Jun 2021 19:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFDRXI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Jun 2021 13:23:08 -0400
Received: from mail-mw2nam08on2127.outbound.protection.outlook.com ([40.107.101.127]:19296
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229778AbhFDRXH (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Jun 2021 13:23:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvpLJhJKBF/ErJsIb7bkGpyerkXsX68lowU1UZdMbbu7fTZM5f+O81SE4J3u84NqYxdJGbm+iUiVqM+m8/orRPOiYSss3xDixyJfnauWYQ+wiJnah410/aH7scm3h3sk+OvXEVlf8V8+uKcofiGOtf48iiEpSHdP3GQN28/qkZzzrdZByvz5kpcqbKBp4wAqh8XMa+COxSxHfx+yp7aAsN6pTf6/b7TEeEXzm9H65KczXxmkDQwf3JlYYJZ/eDsNbCsZCVM7p5ipxeizfVQaJtTJG0pbw2VHCeqAo/xDkuZhJwn/HO+xwUAOBUbMp1tlphc0AyAMnL6G+y7skb8fjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+DGKfRedM44M0MKGSVVZ6kzGyg1KUWgWbiif5iuDBM=;
 b=jIPtMLNi+cQGCoZNDtUeUiqk2NH4HKuVHVJi4a6ahkDvk5TEtCjpw3wBWeq6asxI9KiyVbGiPIcjmKFSKvqnXH8pnpQdRIXme0jCHtX4BKXf6Su1vfYH+2oCwDZsDgf/7DYzdtipX44A5chG+iC3rPnjVtoNYw9AXaKkS+biFy7FOx1h+f0mmTjQlqCS5Hf6qLZ8gPXNHgf0XXKhZpkBcIa+menQFvAGZk1rqUmVmTqfdWT8FpW7kbKiwyLocQEvEN5pfeFT1v1pxBSLYCwnmCL30cuGRyXYPAFMO76N1uen4HXuQHzeXnWC+5NnccdSRYfw2nV8HkVtvfpdhgnJJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+DGKfRedM44M0MKGSVVZ6kzGyg1KUWgWbiif5iuDBM=;
 b=QUfJc2Ets+5Xd5aDkxVlQB7Bb2G2iFTwFr1I6A3lsJe4Do/i6/Tt4lWap8OSfcAM2aK6S84zb1b8Qz5/AT0fO+J+3NstXYEvQpr9U5fL1cf9eS4rT+xAkLAc3N8gjB8xKKL3cG6UuW9HfEXfK97YMG/OVXXYD8ULxC0ug/S9jl4=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1111.namprd21.prod.outlook.com (2603:10b6:4:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9; Fri, 4 Jun
 2021 17:21:20 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::fdb1:c8ac:5a1f:8588%6]) with mapi id 15.20.4219.012; Fri, 4 Jun 2021
 17:21:20 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, jejb@linux.ibm.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     mikelley@microsoft.com
Subject: [PATCH 2/3] scsi: storvsc: Update error logging
Date:   Fri,  4 Jun 2021 10:21:02 -0700
Message-Id: <1622827263-12516-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
References: <1622827263-12516-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.160.144]
X-ClientProxiedBy: MWHPR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:300:6c::14) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.160.144) by MWHPR04CA0052.namprd04.prod.outlook.com (2603:10b6:300:6c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 17:21:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efb2b097-9a0b-45c7-0ae1-08d9277d2b41
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1111:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB1111B197D7CDFFBAE3810221D73B9@DM5PR2101MB1111.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjHH+Mo3kizo1WEHloLgE6d1hofQXRE3+c0XYKwANe8oCYfsnHdl+pOAVPnv47gCR2dRoQidvF9VyDR/1U27SyYe/Tbc0nzMztr90rRT8K6MMPfcl4dXNmxvTqMHkCvrrhdEW08Lmu9QwqQ2eHEUrVM2RMIRl3L+GRu/SiHnQQRzSHYIk2FRWuRYUsNZHhNwPHNno+MNt5HI2UNRIoQY3V7k2sUEJvtZelZLq3r5TAWj9AbjVWh/UOy9Zn0rKR7The27RZXdC3vRzhv0YP+YkjNJPoev/CkPhCjYcF3Is5v/E3ipNEyVCs9Jqsi5Dd6Szfb5NxHb1F7dfV0rmVYqfIJIn+HXbcSe9ZDm4s63Nw+/koESsWUzBOuOHCHyKyEkGH6OOgOCK/3Lor7vV5eW+W5lWxOsZsNQ4MFgrJkPAdVEfx3ohEp0f4PvxlJegELN0/yKsy+R6RycOiELtlhZ4MSSxhki7ZhVAIEeQbEAjBd7fehcsXdTRu6qc7PFTpjLR/qHZyo5Xrhu8q5UnhkuOKfqcX8PI8ogrIgLLH4l8RetiFAfMV0P2k+H8FZectD0oeXgN7W8RHMrIFirNdvh1LNr9m+Xf8Plj3KavUhudYdd8mQguLTbxvBbcexUpPz/NRB7rvZ2t2waGeocb7YT8pqhaIHHEEzIgADMpO+z/62pKyvKHmuDOiKBMxx0QKgMz5QImyLbFntqu0Xl5wUPzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(6486002)(2616005)(107886003)(86362001)(478600001)(956004)(5660300002)(82960400001)(82950400001)(8936002)(36756003)(186003)(2906002)(15650500001)(66556008)(66946007)(66476007)(26005)(16526019)(8676002)(38350700002)(6666004)(4326008)(316002)(38100700002)(52116002)(7696005)(10290500003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IXBxCTpKKZYTyiITMYUPcEg+wmw/8FoyepkJnXVLp19/4t1WD8HBnd6b9LJC?=
 =?us-ascii?Q?GwG/zdHPkFeJ6zVCMhkQnk1co3LUCszuMhjjqciOGtvjZ9/WJp69mYdLYbEH?=
 =?us-ascii?Q?+PZ00VTmwtVpSxHi6+jDtHcw1SKCZ/ThPxMvWxIGMetHGfeoWvS3QFeBs22M?=
 =?us-ascii?Q?NFpSeegZjphKUQ7JDcP1ZmBBRCN9nEti2ozQP4yiPDCIAJ3VT2x2RwbKY+JP?=
 =?us-ascii?Q?ZmbVuxWRMZ+j1ps5JpifblgHxjtGDIR2pvFyFq+OM1a9bKkXF3uRWehqZYua?=
 =?us-ascii?Q?4LBxzvkaJzKJmbV5gLvbwhdBLTy9rxnaOvOdH+zp7CmdHZgVI7HpmmTlGB58?=
 =?us-ascii?Q?PkSHkI+a66+ZBGyhHEgRTrUUk/XJwxwDfD2WgZ/pgckLlo27Wz1oYVTyXhZj?=
 =?us-ascii?Q?kAcp9+j725zJ+zSRaM3dIUHqfi/SckCRW6bwDbLTl1hvdfe/kXECjUrXSzzC?=
 =?us-ascii?Q?SF5Gkck0WbcuN10S6WVOmCQGm9sK7sDU4N11tADvK6qLcAtQFkDYB/20oPut?=
 =?us-ascii?Q?vFxCQZZLIfKW2kkMIxl4Sow6Es1iMGBjv6APimQ13NpuAEehRx8W5jTLOT1y?=
 =?us-ascii?Q?aCYCSWtc9eNF69BdhjcSEjvIvQD1NHOSaRyDLpSV9zG6pRsAA3Fks8P6iL6D?=
 =?us-ascii?Q?/SYO4a2/Of1LWSWSOdaO9HF8dZOFeNZ/BYvxhllrBvqohPkJj18kJvM8cbQf?=
 =?us-ascii?Q?6YoPCC57ezIi5XAAnFJThQIaXiLZrTlcXUlZo78AOL6+suaSW4usTI/SF05h?=
 =?us-ascii?Q?IKeq+Bc4vFFcq6vbpi98tp7h7uTpyT15h53Pn9dJCXCo/fcQnf1dzWcealwH?=
 =?us-ascii?Q?dybdPQbMZbhxSuH95hs1bluwrJN/dpEFK7LHHGOjXk3ZjOl4HFdkvl8Lxbe/?=
 =?us-ascii?Q?bpbL89AIV4u5doL+kyar3Tbagcbg3MLS+UcqsvuprcQN7RQqvdy4QKS0YipQ?=
 =?us-ascii?Q?ZEjZY1out+ZV6RlJQSLd5VAtq8bSPzbdU2oEf1iXMNUhfVkfxA1sfN57Yq09?=
 =?us-ascii?Q?hKFncVpSji+OC01priQe4HBi9x/Akd1dnBm9iQCczZVGX0bDTt0yo0QqMpjS?=
 =?us-ascii?Q?9AH6vEwadjvEnfwCOGDa8s4UHQGJgr56xuEhgBOyIMbtDqVfE3HnLRomWAyQ?=
 =?us-ascii?Q?XEbwf/4tQifXnk8lTXS+fS6uRDylrQ4dVLxeyu9O1nBSIj6DT1YOjfvXl79D?=
 =?us-ascii?Q?YQimcNnupGSxO3Km6RrfaO0/AMrldZEdXSgEesLKiFKqazfz2FTNEiVDFAtY?=
 =?us-ascii?Q?Y8ehn4cQ2KKeG+4uqzGZqiufJJfClG92lwcF2XKciZGrQjlxxEY+wQiZVdWO?=
 =?us-ascii?Q?ixd25BwpWsLWM28wK5udf0bn?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb2b097-9a0b-45c7-0ae1-08d9277d2b41
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 17:21:20.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHHJzI0oXbm4OBeRenAPpWp9elgnLx8sm4k8JuxcTfiXqyu5rAXu/YAdDKK7wS4/rqdWYTxndZa8SsVpMRt4SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1111
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When an I/O error is reported by the underlying Hyper-V host, current
code provides details only when the logging level is set to WARN, making
it more difficult to diagnose problems in live customer situations. Fix
this by reporting details at ERROR level, which is the default.  Also
add more information, including the Hyper-V error code, and the tag #
so that the message can be matched with messages at the SCSI and blk-mq
levels.

Also, sense information logging is inconsistent and duplicative. The
existence of sense info is first logged at WARN level, and then full
sense info is logged at ERROR level. Fix this by removing the logging
of the existence of sense info, and change the logging of full sense
info to WARN level in favor of letting the generic SCSI layer handle
such logging. With the change to WARN level, it's no longer necessary
to filter out as noise any NOT READY sense info generated by the
virtual DVD device.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/scsi/storvsc_drv.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 9996e8b..fff9441 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1090,6 +1090,7 @@ static void storvsc_command_completion(struct storvsc_cmd_request *cmd_request,
 	struct Scsi_Host *host;
 	u32 payload_sz = cmd_request->payload_sz;
 	void *payload = cmd_request->payload;
+	bool sense_ok;
 
 	host = stor_dev->host;
 
@@ -1099,11 +1100,10 @@ static void storvsc_command_completion(struct storvsc_cmd_request *cmd_request,
 	scmnd->result = vm_srb->scsi_status;
 
 	if (scmnd->result) {
-		if (scsi_normalize_sense(scmnd->sense_buffer,
-				SCSI_SENSE_BUFFERSIZE, &sense_hdr) &&
-		    !(sense_hdr.sense_key == NOT_READY &&
-				 sense_hdr.asc == 0x03A) &&
-		    do_logging(STORVSC_LOGGING_ERROR))
+		sense_ok = scsi_normalize_sense(scmnd->sense_buffer,
+				SCSI_SENSE_BUFFERSIZE, &sense_hdr);
+
+		if (sense_ok && do_logging(STORVSC_LOGGING_WARN))
 			scsi_print_sense_hdr(scmnd->device, "storvsc",
 					     &sense_hdr);
 	}
@@ -1173,23 +1173,19 @@ static void storvsc_on_io_completion(struct storvsc_device *stor_device,
 
 	if (vstor_packet->vm_srb.scsi_status != 0 ||
 	    vstor_packet->vm_srb.srb_status != SRB_STATUS_SUCCESS)
-		storvsc_log(device, STORVSC_LOGGING_WARN,
-			"cmd 0x%x scsi status 0x%x srb status 0x%x\n",
+		storvsc_log(device, STORVSC_LOGGING_ERROR,
+			"tag#%d cmd 0x%x status: scsi 0x%x srb 0x%x hv 0x%x\n",
+			request->cmd->request->tag,
 			stor_pkt->vm_srb.cdb[0],
 			vstor_packet->vm_srb.scsi_status,
-			vstor_packet->vm_srb.srb_status);
+			vstor_packet->vm_srb.srb_status,
+			vstor_packet->status);
 
 	if (status_byte(vstor_packet->vm_srb.scsi_status) == CHECK_CONDITION
-	   && (vstor_packet->vm_srb.srb_status & SRB_STATUS_AUTOSENSE_VALID)) {
-
-		storvsc_log(device, STORVSC_LOGGING_WARN,
-			"stor pkt %p autosense data valid - len %d\n",
-			request, vstor_packet->vm_srb.sense_info_length);
-
+	   && (vstor_packet->vm_srb.srb_status & SRB_STATUS_AUTOSENSE_VALID))
 		memcpy(request->cmd->sense_buffer,
 		       vstor_packet->vm_srb.sense_data,
 		       stor_pkt->vm_srb.sense_info_length);
-	}
 
 	stor_pkt->vm_srb.data_transfer_length =
 			vstor_packet->vm_srb.data_transfer_length;
-- 
1.8.3.1

