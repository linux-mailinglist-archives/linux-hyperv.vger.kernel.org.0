Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDDB5B3B7D
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Sep 2022 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiIIPKM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 9 Sep 2022 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiIIPKK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 9 Sep 2022 11:10:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2ED04C622;
        Fri,  9 Sep 2022 08:10:09 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 80FFA204B50B;
        Fri,  9 Sep 2022 08:10:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80FFA204B50B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662736209;
        bh=BQWwqqe1UKwBk425BTnMB7wqR9ai9g0mdnqtA+m/cfA=;
        h=From:To:Subject:Date:From;
        b=fErrCb1qQ1kw6G2AcFQUXHxW+K19T01W/nj4SmkFbSm2W0N3uCpACwitNoXiFN4Qx
         /xFsuyxv9X2ADxZtQCNmgTcBmxewEpcWQceVY+LKrcUTEQncWUXNmBqtV+ya3tkuYU
         5VcOabE/1z9l8DVMUUtdaN2MjSdfRLAEQ5x86r30=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     ssengar@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Subject: [PATCH] drm/hyperv: Add ratelimit on error message
Date:   Fri,  9 Sep 2022 08:09:53 -0700
Message-Id: <1662736193-31379-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Due to a full ring buffer, the driver may be unable to send updates to
the Hyper-V host.  But outputing the error message can make the problem
worse because console output is also typically written to the frame
buffer.
Rate limiting the error message, also output the error code for additional
diagnosability.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 76a182a..013a782 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -208,7 +208,7 @@ static inline int hyperv_sendpacket(struct hv_device *hdev, struct synthvid_msg
 			       VM_PKT_DATA_INBAND, 0);
 
 	if (ret)
-		drm_err(&hv->dev, "Unable to send packet via vmbus\n");
+		drm_err_ratelimited(&hv->dev, "Unable to send packet via vmbus; error %d\n", ret);
 
 	return ret;
 }
-- 
1.8.3.1

