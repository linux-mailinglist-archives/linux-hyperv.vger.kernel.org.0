Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EC54BBFB2
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Feb 2022 19:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiBRSmx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Feb 2022 13:42:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239366AbiBRSmw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Feb 2022 13:42:52 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF59355BC5;
        Fri, 18 Feb 2022 10:42:32 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 27so3382256pgk.10;
        Fri, 18 Feb 2022 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7nqOGY4TY+vmWCFgHHJJ6SJZGD1lDi6QuXxkYn/JbY=;
        b=W7+WcQonDxk3UPONlSTVhlNDY8TS48sVtuorDKBztSniSB71RWw4QsVlAAbanRr/ze
         vs0Y+hqhD54iRQtE4EqnF42w+ohc2J4UQSBMBof16AKZJ2jOJNiHnMmyiSNbkntDsRKK
         woMwECyw+inIIfBnMqaJFhT7hYFNZBbug0GXcl8r++Bt090UCcy/IfILDRgW0zy9acaC
         LYuEcGo0/MLJxlktO1KG7drN/JW4d6RpY7kzR32TQlGhejURvBnQ7ch7NuCg8dWcH1LT
         9dKqUVoI2BC9/jcwC0JUrhtI682FmbMvnugb5S2IVDBCCeESH7biqQraKUnwDLlejRah
         tfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7nqOGY4TY+vmWCFgHHJJ6SJZGD1lDi6QuXxkYn/JbY=;
        b=I/YPAaO/mzgBl0UG9YFvbOWswLYLhvRJcCUpxbnhfDDBmeHQpf3F6bYKw7sqMzYp2o
         ipWTOX201LWOKaNOGCPAH/bBllUZNKQ/9WFMB08dINJiAF3eqKOgWv8VLNkvhrFvvrS4
         CsLS9uH/eWWq+FKbk1tBQxJeszpjrWWOga3lx0t5oCaZoC3y5uPj+39kQgoeH3dMybdt
         S7nmDVoMoAGvyDWKgKUGFQIl5++r0472IXBFwmsHa/Illsn+sASzLVqyDQRJXWeZD62s
         2CfAgNZcU1c/K6lGndPlm+XtK98kBeF0M6CPqT34X6haPFSLcYgw+1erHtWchi16Ea8H
         0a4Q==
X-Gm-Message-State: AOAM533IBQF0A6KCLQjVWPIoMVOJJQ2zJjfJYYLSd+MKIJkdUb3134cZ
        zN4qZNo4B8s2DwiG3lgS63w=
X-Google-Smtp-Source: ABdhPJxBDP2NlrsFO/QvhW1y6vyFhXp7WPAy8pBV0Tr+1A9FJiQroodyjttynDYAFnPr93u9pbyOqA==
X-Received: by 2002:a63:f506:0:b0:373:13fe:90a with SMTP id w6-20020a63f506000000b0037313fe090amr7426142pgh.254.1645209752190;
        Fri, 18 Feb 2022 10:42:32 -0800 (PST)
Received: from vm-111.3frfxmc3btcupaqenzdpat1uec.xx.internal.cloudapp.net ([13.77.171.140])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090ab79100b001b89fd7e298sm130132pjr.4.2022.02.18.10.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:42:31 -0800 (PST)
From:   "Melanie Plageman (Microsoft)" <melanieplageman@gmail.com>
To:     mikelley@microsoft.com, jejb@linux.ibm.com, kys@microsoft.com,
        martin.petersen@oracle.com, mst@redhat.com,
        benh@kernel.crashing.org, decui@microsoft.com,
        don.brace@microchip.com, R-QLogic-Storage-Upstream@marvell.com,
        haiyangz@microsoft.com, jasowang@redhat.com, john.garry@huawei.com,
        kashyap.desai@broadcom.com, mpe@ellerman.id.au,
        njavali@marvell.com, pbonzini@redhat.com, paulus@samba.org,
        sathya.prakash@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        sreekanth.reddy@broadcom.com, stefanha@redhat.com,
        sthemmin@microsoft.com, suganath-prabu.subramani@broadcom.com,
        sumit.saxena@broadcom.com, tyreld@linux.ibm.com,
        wei.liu@kernel.org, linuxppc-dev@lists.ozlabs.org,
        megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
        storagedev@microchip.com,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com
Cc:     andres@anarazel.de
Subject: [PATCH RFC v1 2/5] scsi: map_queues() takes tag set instead of host
Date:   Fri, 18 Feb 2022 18:41:54 +0000
Message-Id: <20220218184157.176457-3-melanieplageman@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218184157.176457-1-melanieplageman@gmail.com>
References: <20220218184157.176457-1-melanieplageman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Change the scsi_host_template->map_queues() to accept a blk_mq_tag_set
instead of a Scsi_Host as a function parameter.

A future commit will introduce the concept of device tag sets. Thus
map_queues() cannot assume that the target blk_mq_tag_set is accessible
through Scsi_Host->tag_set.

Generalize map_queues() by changing its input to a blk_mq_tag_set.

This commit makes no functional change, as the Scsi_Host->tag_set is
passed as the argument to the LLD map_queues function.

Signed-off-by: Melanie Plageman <melanieplageman@gmail.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c    | 5 +++--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 5 +++--
 drivers/scsi/megaraid/megaraid_sas_base.c | 4 +++-
 drivers/scsi/mpi3mr/mpi3mr_os.c           | 4 ++--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 3 ++-
 drivers/scsi/qla2xxx/qla_os.c             | 7 ++++---
 drivers/scsi/scsi_debug.c                 | 5 +++--
 drivers/scsi/scsi_lib.c                   | 4 ++--
 drivers/scsi/smartpqi/smartpqi_init.c     | 5 +++--
 drivers/scsi/virtio_scsi.c                | 5 +++--
 include/scsi/scsi_host.h                  | 2 +-
 11 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index a3cf413f6990..e850797e4c18 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3538,10 +3538,11 @@ static struct attribute *host_v2_hw_attrs[] = {
 
 ATTRIBUTE_GROUPS(host_v2_hw);
 
-static int map_queues_v2_hw(struct Scsi_Host *shost)
+static int map_queues_v2_hw(struct blk_mq_tag_set *set)
 {
+	struct Scsi_Host *shost = set->driver_data;
 	struct hisi_hba *hisi_hba = shost_priv(shost);
-	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+	struct blk_mq_queue_map *qmap = &set->map[HCTX_TYPE_DEFAULT];
 	const struct cpumask *mask;
 	unsigned int queue, cpu;
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 169eb5fbecfc..75a2b4ccbd95 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3135,10 +3135,11 @@ static int debugfs_set_bist_v3_hw(struct hisi_hba *hisi_hba, bool enable)
 	return 0;
 }
 
-static int hisi_sas_map_queues(struct Scsi_Host *shost)
+static int hisi_sas_map_queues(struct blk_mq_tag_set *set)
 {
+	struct Scsi_Host *shost = set->driver_data;
 	struct hisi_hba *hisi_hba = shost_priv(shost);
-	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+	struct blk_mq_queue_map *qmap = &set->map[HCTX_TYPE_DEFAULT];
 
 	return blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
 				     BASE_VECTORS_V3_HW);
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 05db8f0b1e7e..d579cb41355e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3168,12 +3168,14 @@ megasas_bios_param(struct scsi_device *sdev, struct block_device *bdev,
 	return 0;
 }
 
-static int megasas_map_queues(struct Scsi_Host *shost)
+static int megasas_map_queues(struct blk_mq_tag_set *set)
 {
+	struct Scsi_Host *shost;
 	struct megasas_instance *instance;
 	int qoff = 0, offset;
 	struct blk_mq_queue_map *map;
 
+	shost = set->driver_data;
 	instance = (struct megasas_instance *)shost->hostdata;
 
 	if (shost->nr_hw_queues == 1)
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 284117da9086..38e27e3b392e 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -3167,8 +3167,9 @@ static int mpi3mr_bios_param(struct scsi_device *sdev,
  *
  * Return: return zero.
  */
-static int mpi3mr_map_queues(struct Scsi_Host *shost)
+static int mpi3mr_map_queues(struct blk_mq_tag_set *set)
 {
+	struct Scsi_Host *shost = set->driver_data;
 	struct mpi3mr_ioc *mrioc = shost_priv(shost);
 	int i, qoff, offset;
 	struct blk_mq_queue_map *map = NULL;
@@ -3205,7 +3206,6 @@ static int mpi3mr_map_queues(struct Scsi_Host *shost)
 	}
 
 	return 0;
-
 }
 
 /**
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 74cdf72ef837..4e3a9fff023e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -11868,8 +11868,9 @@ scsih_scan_finished(struct Scsi_Host *shost, unsigned long time)
  * scsih_map_queues - map reply queues with request queues
  * @shost: SCSI host pointer
  */
-static int scsih_map_queues(struct Scsi_Host *shost)
+static int scsih_map_queues(struct blk_mq_tag_set *set)
 {
+	struct Scsi_Host *shost = set->driver_data;
 	struct MPT3SAS_ADAPTER *ioc =
 	    (struct MPT3SAS_ADAPTER *)shost->hostdata;
 	struct blk_mq_queue_map *map;
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index abcd30917263..915fee7f9d08 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -335,7 +335,7 @@ MODULE_PARM_DESC(ql2xabts_wait_nvme,
 
 static void qla2x00_clear_drv_active(struct qla_hw_data *);
 static void qla2x00_free_device(scsi_qla_host_t *);
-static int qla2xxx_map_queues(struct Scsi_Host *shost);
+static int qla2xxx_map_queues(struct blk_mq_tag_set *tag_set);
 static void qla2x00_destroy_deferred_work(struct qla_hw_data *);
 
 
@@ -7881,11 +7881,12 @@ qla_pci_reset_done(struct pci_dev *pdev)
 	clear_bit(ABORT_ISP_ACTIVE, &base_vha->dpc_flags);
 }
 
-static int qla2xxx_map_queues(struct Scsi_Host *shost)
+static int qla2xxx_map_queues(struct blk_mq_tag_set *set)
 {
 	int rc;
+	struct Scsi_Host *shost = set->driver_data;
 	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
-	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+	struct blk_mq_queue_map *qmap = &set->map[HCTX_TYPE_DEFAULT];
 
 	if (USER_CTRL_IRQ(vha->hw) || !vha->hw->mqiobase)
 		rc = blk_mq_map_queues(qmap);
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index af7ad912fabc..a0327ef6ef83 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7272,15 +7272,16 @@ static int resp_not_ready(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	return check_condition_result;
 }
 
-static int sdebug_map_queues(struct Scsi_Host *shost)
+static int sdebug_map_queues(struct blk_mq_tag_set *set)
 {
 	int i, qoff;
+	struct Scsi_Host *shost = set->driver_data;
 
 	if (shost->nr_hw_queues == 1)
 		return 0;
 
 	for (i = 0, qoff = 0; i < HCTX_MAX_TYPES; i++) {
-		struct blk_mq_queue_map *map = &shost->tag_set.map[i];
+		struct blk_mq_queue_map *map = &set->map[i];
 
 		map->nr_queues  = 0;
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 61795bab83f7..bba66e29d38c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1864,10 +1864,10 @@ static int scsi_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 static int scsi_map_queues(struct blk_mq_tag_set *set)
 {
-	struct Scsi_Host *shost = container_of(set, struct Scsi_Host, tag_set);
+	struct Scsi_Host *shost = set->driver_data;
 
 	if (shost->hostt->map_queues)
-		return shost->hostt->map_queues(shost);
+		return shost->hostt->map_queues(set);
 	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 }
 
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 31c0c2054d6a..d81ead36d9f1 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6332,11 +6332,12 @@ static int pqi_slave_alloc(struct scsi_device *sdev)
 	return 0;
 }
 
-static int pqi_map_queues(struct Scsi_Host *shost)
+static int pqi_map_queues(struct blk_mq_tag_set *set)
 {
+	struct Scsi_Host *shost = set->driver_data;
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
-	return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+	return blk_mq_pci_map_queues(&set->map[HCTX_TYPE_DEFAULT],
 					ctrl_info->pci_dev, 0);
 }
 
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 0e6110da69e7..6595e142e2e4 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -711,10 +711,11 @@ static int virtscsi_abort(struct scsi_cmnd *sc)
 	return virtscsi_tmf(vscsi, cmd);
 }
 
-static int virtscsi_map_queues(struct Scsi_Host *shost)
+static int virtscsi_map_queues(struct blk_mq_tag_set *set)
 {
+	struct Scsi_Host *shost = set->driver_data;
 	struct virtio_scsi *vscsi = shost_priv(shost);
-	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
+	struct blk_mq_queue_map *qmap = &set->map[HCTX_TYPE_DEFAULT];
 
 	return blk_mq_virtio_map_queues(qmap, vscsi->vdev, 2);
 }
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index f7f330f9255b..1255e8c164f6 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -277,7 +277,7 @@ struct scsi_host_template {
 	 *
 	 * Status: OPTIONAL
 	 */
-	int (* map_queues)(struct Scsi_Host *shost);
+	int (* map_queues)(struct blk_mq_tag_set *set);
 
 	/*
 	 * SCSI interface of blk_poll - poll for IO completions.
-- 
2.25.1

