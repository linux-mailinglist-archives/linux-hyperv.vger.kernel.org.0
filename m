Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4054D7084B8
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 May 2023 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjERPOm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 May 2023 11:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjERPOl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 May 2023 11:14:41 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323DB119;
        Thu, 18 May 2023 08:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GL/PoL+KDHaMXvnyGM3wmnW65W5AJy85o82+JtFeuEOvKJkoy7cRYHvntv0jTEiBvIoTcOLCPjENTfa+yQEz8g0wfaNhi4j4oYbgvTdO7ASGxCzkcqzCM1yHcWMu8f76JxAQvietpnIk8AJCM3UFnq3YzwittEDF/DwEIw4OqaKAPZR2t66S+pc6Nbhl+ppw3l1idpNNPZ43LVFWUQHkM0Df3J+/Enuwbv8G9T8yyDFwjyK6yeIxjgo57rOtRWo+rsXYnh8zjgv4qBgzzKxOXHiE37oujbr7be3sCggjWAZGxYoZKL426no6chegpO8m4AJQHqVKfjZ6hoqDdXmF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7IaCsmwMXghF0Wa0lt8/SC0QjzVqzUsAbk94IPtFqM=;
 b=YmTDhuNSWk5xxcNt5OoykzhEZiy4gbsPU/0ZIefaIzSjoPeG0ARYM08rZyLf4/sNR0CL09ddCiRqIhlfOzkp83lunwTxh1pC/M5DVt9JH4JlVS0dk/h5Y9TWdtfUd/CSriN7zmiacQkioHt+lRdMIHtK21rY0fv+tfy+ceQRoRBjsIe+izRpj6kEWudHwd/iCmyLOjl2jWKYE3SPjswt4+GkxIqK75xZZw+1G9uWpFLeS6eztM1oypSZtcXnEb/V7hKdDHrkqtjyd7CZGwQ336qxsTlGFl11VDTnJgnbQtsna19m/UZ4A1ifvOxz6HLcxTmNDFz6wOTBxJ26tRfn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7IaCsmwMXghF0Wa0lt8/SC0QjzVqzUsAbk94IPtFqM=;
 b=c85vjnhDUirjQj87bOgpD2Zw2zq0iKXTtie+6lz8jlAL5I4IFFY5+i6Y3ddYq+zZ5438rnIfh7NPnm0EtXLN5z+H7W1dz0m1aGFaqHARWN8d2XhqLvQsEVL1oYTSD0ozwLByndVJYObDCehOce0Yjj3c8TlHd+lqqkrCj4VevjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1370.namprd21.prod.outlook.com (2603:10b6:5:16b::28)
 by SN7PR21MB3827.namprd21.prod.outlook.com (2603:10b6:806:29a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.6; Thu, 18 May
 2023 15:14:36 +0000
Received: from DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f]) by DM6PR21MB1370.namprd21.prod.outlook.com
 ([fe80::b7e9:4da1:3c23:35f%6]) with mapi id 15.20.6433.006; Thu, 18 May 2023
 15:14:36 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        vkuznets@redhat.com, decui@microsoft.com
Cc:     mikelley@microsoft.com, stable@vger.kernel.org
Subject: [PATCH v2 1/1] Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to scan present CPUs
Date:   Thu, 18 May 2023 08:13:52 -0700
Message-Id: <1684422832-38476-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0198.namprd15.prod.outlook.com
 (2603:10b6:930:82::14) To DM6PR21MB1370.namprd21.prod.outlook.com
 (2603:10b6:5:16b::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR21MB1370:EE_|SN7PR21MB3827:EE_
X-MS-Office365-Filtering-Correlation-Id: ff34140c-6c2f-4a6f-f03b-08db57b2944a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1im+lOj89g077grve6MqxlmAAec5oH2j/M0HwOynh1zCrkweNQesjXkquPOtfAIzfAM3HWDOWYkQQbU2cwPr+5NT3m6BR3+jpoYsinkh3Pbop/TWeA4acpFLFsh/3D+Bm9XcuSHhZa98xaV9jmOEU9CFYkExlsZk69h8XQKgKsC86pEtP80o7GLecPrKMBRfks3Iv28L98aSW5Zaqp9BL6Q3vYZJT0Mm6wF3zJ5+EDJe5crPlcj6F1nOpOS1uOOLOQwSm/yNE7FIyjGm/51S2ix7fhUmHnXi0LtiePApD/15ZLb7s3LvacCPCL4zD+93Wt3W+VCNekwvyjSK0EHdRHaXfjtGPoj41LwqfDvAZNNwko/w4mC1FhPOsdqloBlY9zuU3cbu78f4Aq+8KfNL9ppoxmjrs8pmP0nSMAzkIym+96o1dJnqyZfvdFc+LwAJajJbCWkZB5xGOOpeZZw2pAzh4u0rJHthJMoZ35AYQv6QsD32hJsUSR3lK4Em28w44aE6yR7t+xtBEEgMdleg6JFMG0anol+taTCvmmHP52axVhN/gzM/sYc/tbSCuWNkN3h90vDcAYSWNU6UkkmaNgPsI1X4dmdmujGSesLxTjB+0imI/RxJrGP4FyglM0dExTqqIFD2vlmUiR1znW8VWyD70mcweJg5sWkIn8ihJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1370.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199021)(52116002)(6666004)(6486002)(41300700001)(36756003)(38350700002)(38100700002)(6512007)(6506007)(26005)(5660300002)(2616005)(83380400001)(186003)(2906002)(86362001)(8676002)(8936002)(82960400001)(82950400001)(66556008)(66476007)(66946007)(6636002)(4326008)(10290500003)(478600001)(316002)(786003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pu+227EXLe8mSPYmEc3gRbDAlw6fP/v7S2R8QamQIFhECx3etOu++6Vv573r?=
 =?us-ascii?Q?qs+5oRAa4ieC9GWYB/umd6ri1kJRp2Zd1qWIoZZu2IQYFasjS0QmT5WKhoYH?=
 =?us-ascii?Q?j/yQ5eYCFhGpHUDmBn3sc7kzSLTNaSzdBzbhxMS5FJICHC34P/rvQ2MEtMRD?=
 =?us-ascii?Q?gYEoaVPv/EuRO3Zu4jNn1cBPKMy4T1kUGAEDtcxRJV8SMEUknx0IwgiAfuG+?=
 =?us-ascii?Q?jzMfAtcdqXVIqlbdy6xCvess1zZ477nGx6JByW4tZYxX7nYhBvldRjvAWjYH?=
 =?us-ascii?Q?Q/ZNULWoWZiZw17xKMgL63W6mDiFc/gMM4GvqFfRJhwIN6q4ZKa29JkKs76q?=
 =?us-ascii?Q?ERswLjX267TlB0LvB8k92KHsh7Sd/N6WaMKyLbPIG56qZ5uysxZ0Rl6TMcx4?=
 =?us-ascii?Q?RhilFpcQRccyZxG4PueDQsjPZ0X6mqenPh715Jkw0KMZKYvZaWg61z2ywQxA?=
 =?us-ascii?Q?JK067X3bZzKoc+0Lmc5uJg+xNWk0ENdVNbsFfgpU7yKwsYaL6R5/SsctbYec?=
 =?us-ascii?Q?1SJB2L8O4V8tK1fiI5UpxsmunS3GKk31Or7F6ryOJeku7bjlNQ9bGRtEeQmx?=
 =?us-ascii?Q?Kyu91hMkz5fJBzxiHhrEQTtB94ojbc5fOPE4tvQeZMrYeLqS54OsLZKt9pnK?=
 =?us-ascii?Q?DDln8WVEt/qel5iewqaPDIcFLi4+Bdt0fY5EftbXcc6xcC8rI1irMfJj4qy7?=
 =?us-ascii?Q?9ARTZ6FBhzyflK0jYSEKzBCx1rIaEn6WrIigfkIEcOdV0uLk1pip6Zx71atJ?=
 =?us-ascii?Q?0chCOP2U7fwTFJHDh+Jpj/+EFGIRHYeMsunt08oopsqM5rl0ho63LL6p5RAB?=
 =?us-ascii?Q?1r5fmAxDXmNuD8NRakSEYVGhdb5gHyvgf1enR4wocQtjSJUtT0KTQgU7iWZs?=
 =?us-ascii?Q?UvaAFtIwcdyRfAfAk13svrOCXCsSogLBpn5LgAR+RT5CgFpXO9N5K6ap4piB?=
 =?us-ascii?Q?/mttCXtG71cJUr3VTZ2p1e908KAmPM6wHD6Esf22vMeQ+kp9t0v6mxIk94b2?=
 =?us-ascii?Q?oG0tSFLB4Z6oZWjJmNfIgvgC5+sDogCNs/loRC7Ym06CvhbxAB5qgWqj4cyy?=
 =?us-ascii?Q?JcJ+DeRpzx1Ewwssw6yVo6RpEETCR0zhSH4q8HYflJE+aND8oO3lSIK5uaLa?=
 =?us-ascii?Q?lnIpkhcRnVg8+AA+EaIXiTt0juuTc1CMoZy1JC9UEMX7WNg2sExw+85SbzQD?=
 =?us-ascii?Q?T5LkRukyb4cHtMCF1DlYTycrjF3LB+amhHZ7lo1fd9HoRmyjy/W8Ua/tDeLM?=
 =?us-ascii?Q?1NeXGeJxwlyXvX9nu+L11AXJxRRDcU2POdQ0hZLF5qTn4SCGMpbXS1Dgu/Gy?=
 =?us-ascii?Q?jmF3GqhVo7miwGidbD9h/aMu1c5HkshN+22GJzqmGnBoFaxU+2uZglad0hF7?=
 =?us-ascii?Q?QdN7/WPSH/ejsQIYrsVN5XYK8iSPTc0Yu25qAX7U6yJe3zhKLBfdSblqbtnR?=
 =?us-ascii?Q?HPpLJgJRFkWPlSfGHiXdcZNo6q4XugjEucPUmQEP9RmWkdfRLb672UQaLzBc?=
 =?us-ascii?Q?qc8YtLNQchA8FozFV3M3CSw5yr9Pz6IDGmmrxKdMHfPQ1g7KWw14VyqfPB8M?=
 =?us-ascii?Q?rQU5s/zN4hU/s63E7KkqQ7o4Ti1CHg0DGNiuHoZW?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff34140c-6c2f-4a6f-f03b-08db57b2944a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 15:14:31.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KP7kBU77bIytZYGzvmNFB/GRCR7d58ZQFarx31cIu4U+ugFRaFGCfif5vmloeo2VMFdbe3HwA690vKNOOGSew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

vmbus_wait_for_unload() may be called in the panic path after other
CPUs are stopped. vmbus_wait_for_unload() currently loops through
online CPUs looking for the UNLOAD response message. But the values of
CONFIG_KEXEC_CORE and crash_kexec_post_notifiers affect the path used
to stop the other CPUs, and in one of the paths the stopped CPUs
are removed from cpu_online_mask. This removal happens in both
x86/x64 and arm64 architectures. In such a case, vmbus_wait_for_unload()
only checks the panic'ing CPU, and misses the UNLOAD response message
except when the panic'ing CPU is CPU 0. vmbus_wait_for_unload()
eventually times out, but only after waiting 100 seconds.

Fix this by looping through *present* CPUs in vmbus_wait_for_unload().
The cpu_present_mask is not modified by stopping the other CPUs in the
panic path, nor should it be.

Also, in a CoCo VM the synic_message_page is not allocated in
hv_synic_alloc(), but is set and cleared in hv_synic_enable_regs()
and hv_synic_disable_regs() such that it is set only when the CPU is
online.  If not all present CPUs are online when vmbus_wait_for_unload()
is called, the synic_message_page might be NULL. Add a check for this.

Fixes: cd95aad55793 ("Drivers: hv: vmbus: handle various crash scenarios")
Cc: stable@vger.kernel.org
Reported-by: John Starks <jostarks@microsoft.com>
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---

Changes in v2:
* Added a comment and updated commit messages to describe scenario
  where synic_message_page might be NULL
* Added Cc: stable@vger.kernel.org

 drivers/hv/channel_mgmt.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 007f26d..2f4d09c 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -829,11 +829,22 @@ static void vmbus_wait_for_unload(void)
 		if (completion_done(&vmbus_connection.unload_event))
 			goto completed;
 
-		for_each_online_cpu(cpu) {
+		for_each_present_cpu(cpu) {
 			struct hv_per_cpu_context *hv_cpu
 				= per_cpu_ptr(hv_context.cpu_context, cpu);
 
+			/*
+			 * In a CoCo VM the synic_message_page is not allocated
+			 * in hv_synic_alloc(). Instead it is set/cleared in
+			 * hv_synic_enable_regs() and hv_synic_disable_regs()
+			 * such that it is set only when the CPU is online. If
+			 * not all present CPUs are online, the message page
+			 * might be NULL, so skip such CPUs.
+			 */
 			page_addr = hv_cpu->synic_message_page;
+			if (!page_addr)
+				continue;
+
 			msg = (struct hv_message *)page_addr
 				+ VMBUS_MESSAGE_SINT;
 
@@ -867,11 +878,14 @@ static void vmbus_wait_for_unload(void)
 	 * maybe-pending messages on all CPUs to be able to receive new
 	 * messages after we reconnect.
 	 */
-	for_each_online_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		page_addr = hv_cpu->synic_message_page;
+		if (!page_addr)
+			continue;
+
 		msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
 		msg->header.message_type = HVMSG_NONE;
 	}
-- 
1.8.3.1

