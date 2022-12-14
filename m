Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB8C64C273
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Dec 2022 03:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237034AbiLNCzf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Dec 2022 21:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiLNCzd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Dec 2022 21:55:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1772E32F;
        Tue, 13 Dec 2022 18:55:32 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDLNhNR024496;
        Wed, 14 Dec 2022 02:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=5eXG7jq+Rf+vyfLS3oIcPPqvgoGammzWZZYCVooZD+M=;
 b=GRqyvIry0LMvSDpt94/6Q3IiDSzZrF4z4f1hTAvYGMXba/Pzbl0KBtIlxtqj2+qOpk7f
 VMT2M2hVy4wsNi7cZOd1tu0LvaooVjcusNQa6eHqslHm4k0pKjfgWRBxJRNBUSHJLTZr
 T3fGz+QspehtlPqFtr/J1+8Wrv+PZ+4Y7x0YgleTwoid2xKFpP4M0thzzMaI5vUKYqtn
 b0OfZQ6wv+1krK9Yhff/nI2xGKi7DiOxusR2DEkFoX+C2t+dE9CuthhoaXOKGUi4F4eN
 qbGG96rfJvmdpSXEMQ+KAAZfF0TqqO9DaqLPkCYV7iKPh6xmlTaBMewXu0dNtoQUCBMZ uQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyerrunr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 02:55:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BE02VlC031290;
        Wed, 14 Dec 2022 02:55:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3meyet8h40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Dec 2022 02:55:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwmP9PKCWohUNlOzQXPrCWefIV8BZxdRM7JgtN8EnM9QCR3LLs2V68VVzqnb37PJzIbyL0KCAvSxoR/ygbNgbrzhzdpJNZPF83wOP+D1bX0Uib8n8r0rksvYbjoMGUcGd3kdspphhTpIgKE+NIQFtKsoUHfU9vbOTKCaeQR7C1EG5PqevysMkrj3ZaKiCxDi1SMS/Ii561cN9gtYhcajl/eUB4+BzP2UhRuePz1YWlgt0IZcs4E2tKVlE/s8zYus1i0f5sjPqhGqSigqI949/Xqky2jYrVbLORM3v2uZCyMnSh/ghw5wVwxMnGWBKaJpFBbWA7ew9BA5AAqij3rkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eXG7jq+Rf+vyfLS3oIcPPqvgoGammzWZZYCVooZD+M=;
 b=OmCN45KX3kkV6cY41uGxPYQkjJ774mORfGopA53Qf/oAjB5t/HIUAvmx5aklyKdWpYLet9GYdch966w6ZimkC6icT5aKtx+G9quqEKlFqzECA/jSN78UoB7QlxocHOV4h8ZkIH9vrV1Jv1monY1NW4VRQXdC2PKdX3AmAvJwkHrzSVqSrq/k5XLTJWnTYB+9H3DQAMaYmnS1Ab+zu0iuhGe6TonstL8x+pD/EA7yQk3nRIbc9BKDc0Z8i3olNeEtMPTUtSiq8WGfcXn/M7RR3tqIM4gRO/x1yS0jD3sw07nkt28WmiD2ebAY9rgGN5T0EqzyS9zS74fb09CZBzmMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eXG7jq+Rf+vyfLS3oIcPPqvgoGammzWZZYCVooZD+M=;
 b=pmGY3djzGs83G7AXzwIgAcHnr6gpk98l+ok7cVsiJRGoHecYtxiI1nKfPMmju9XznHeVNal9e/x3zkPwYWfZaWwPK5jr4FfTeC99mgkHQixrgUImchBVj9nAkr5K/tHufOrt4GSHK9sF8e0Ifbu7UnqSgRloh2ugM1W4QrYw1hE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB4343.namprd10.prod.outlook.com (2603:10b6:610:a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Wed, 14 Dec
 2022 02:55:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 02:55:16 +0000
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, martin.petersen@oracle.com,
        longli@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: storvsc: Fix swiotlb bounce buffer leak in
 confidential VM
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0x2eltj.fsf@ca-mkp.ca.oracle.com>
References: <1670183564-76254-1-git-send-email-mikelley@microsoft.com>
Date:   Tue, 13 Dec 2022 21:55:13 -0500
In-Reply-To: <1670183564-76254-1-git-send-email-mikelley@microsoft.com>
        (Michael Kelley's message of "Sun, 4 Dec 2022 11:52:44 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0178.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH2PR10MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecf4895-e65f-4a57-2695-08dadd7ea0a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imLCi0cOTJyGi0Qgs2PgItK+x5fdeLHcwpAiUxZ1nxNBLenHI8s0lZPEDveFa3dZkbk3lMidWux7d7wCABfmxn3gMU/3oeq6UTI8khjavfGQUk7eARnyP6yuwtWcCL42xOLg+K3GDmrdsATw+3UGklQqxkpQNP0pQq1vNVAjrjOMve7viOTAkKCigeGeTrz2AY+gX1sI3e1M88OxgiK6VVkGuhpXslDWf2BCbke11e5+MFi8xMv+FzZDc7vr3PQS/hdK1GWOOpwjvFmorocToAPGGtuUrokosAUwlovPA8chKo6jZjJE6IzB+6DUbhU1moP9pRZ/0Z6zf0jLmF1KR7dsoFIb+9huxEh7sQEzT/0vZyhZob2bZqIYkzOB/N0Tj94cI4rytrIq43u9yu9o/tulL4qOyKUfcg1pjQwJH5oB0/M88285VND1T/CpD4rpDD7eDjFveB2YJnCiK70gvxAsDcnyr6aTVuckmQqDORZwHy3dL/WThd9f0havFmJ8AAtSm/yIRb/kt8NUbTRIf2ceea1bTvpIgXHwXqnsCmqZPhVq8WsOAxeTlkYxOs92I//MIiwpO4d5wk47zIrcMbZ8M5ZhzGgO8rRtrGjBVUJH93wxOxKpqfPRvNOFN4msk/oaF9+RqUrS1BMu/gbXGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(6506007)(36916002)(6512007)(26005)(186003)(2906002)(478600001)(6666004)(6486002)(316002)(6916009)(38100700002)(8676002)(66476007)(4326008)(66946007)(66556008)(8936002)(41300700001)(4744005)(83380400001)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uq4PzM8eQhN2E3mRrz45lrorFI8GieFdSNNdTlwkAcPG77rY8Cm1mfha3kJU?=
 =?us-ascii?Q?89s9rcNTu8GkDD3F24I+Ln8C5J2a7upt40CDUwbToB4b5tB0Ivt9q+edWEoe?=
 =?us-ascii?Q?d0fX04N3nCpxdPK7FdVkNEfBMKOrvETH3POoHpbbHnD62AKIxoJ9gfvg0tgU?=
 =?us-ascii?Q?xL6n+JPQrFWYZVYzN6oT9ELyFbvC1Qu6rn1QuqvhysDGeUDUtS3BFMffNgt/?=
 =?us-ascii?Q?jxDCjHRnuOb4fgeAdqkxHnDgJW6UDPRrYy2gAOvyU1+Uuiyrvoe5DGoytcq+?=
 =?us-ascii?Q?+K9SCyaxzskSWknI95tso6PnnliG4t/S0XxWTGiVD3e6SN6zPqpsbUCx11dF?=
 =?us-ascii?Q?kwxlWhA1lncQstcZXF5l/XhCuCNj4PrYjaJCSD68hRgC7Ka4NP/X8TGLdEYS?=
 =?us-ascii?Q?sihN+RJ/LpDsv5h5jw+CpzV86dPTvKMrX9E1rjFkNHbOIq4rhRoueoxJo5OV?=
 =?us-ascii?Q?GG9GJuQJCCMvyDDm9Xp8yix5/rvCZ/y4DyNY18Xs4xVETZOic5r8ujS6n76k?=
 =?us-ascii?Q?kBb/DbA4VC7IEtMrhwAm1IFdPkNCRZ5a9V7FMdWEHYaieTPUByzscLhjpR2e?=
 =?us-ascii?Q?RAnzzo1Sss2HQERFG/Tf8HNzPGqhdiweZBsU5Cjn7riZswP6qGse+1rNDIGT?=
 =?us-ascii?Q?+Yi5pztdSM6CyIxNgnNo8ujFzzLL9NDNL4ohs4EUoL+jDby/BG1sSHfZf4Z1?=
 =?us-ascii?Q?GuxMOdQgMUWjo3c5La0Kmc65jvc9NywdTn5Egi0kk/dDgydcpr2rz7vo2Xyd?=
 =?us-ascii?Q?8vl8VSwg9AEqy1hzCemfvCeAhKNpxqUS451/joLqCrS4cfBy2sNXA/W1Fcu1?=
 =?us-ascii?Q?eobPhofVgUYE3KJXzylvYzzfO+7AO1A1cqlnu9vtBL5+ud4D7uvgU9yYsD0E?=
 =?us-ascii?Q?6l1d2HZLVHTJ5hQKQKlMSOdzJPgxeZUkgZwGhpi0UPZs/xG5TaMOW7y7qMZG?=
 =?us-ascii?Q?nNoC3LcMZI4LNJ8wBv/Z4sZh0W4qKX08yRTiNwCkHj/DceN4Thj6ga+XoA2n?=
 =?us-ascii?Q?Nar2/hSLuyXnsD7HnjvJP5cSELeKpCJFA84ChSeRVsyvXzIyBpgcLPBgWPlN?=
 =?us-ascii?Q?QcD5CVlw5IXmdjqzE5XeU++D5box1bm24SrldWLXgvNW/9CpxQyFfV2auoIo?=
 =?us-ascii?Q?ET8mTgliKTLQgKekBVFFIZ/mlMbI7CXCKVTwDFLfy43XhJPPHFGga4g0ploy?=
 =?us-ascii?Q?fGat4nfLFlVTwHlq+h2yxBSdhCFs2Re8GWsYCvvPNIHEclD/WFLMdB6hqDLm?=
 =?us-ascii?Q?iaTH3900BlkkMsB9kdnDXLFwtclOQTj9PoE4VytD/PWVcR1I1X8mvoPp55AU?=
 =?us-ascii?Q?HIrFsgog4lIpyjVXJ+7yKgcz1koOrwNcIV5s4aQ4pkSJp/K4QvFDGbteYfB/?=
 =?us-ascii?Q?XFSSsQGNCVYWVMMak5p9jbRJen9oDLI007rnRqjfTcU2dE/zu8JcbABtNMoE?=
 =?us-ascii?Q?FrVsg6rWm8R7mYx4jbE4hMTIJYrjziwxhrqOu2pdTTjNAnDEZoGqBFVLw7/B?=
 =?us-ascii?Q?uSynZcpSJD2vbY5f1STo2stLMQjsHtE/CiS4AfJsD/qNsGCv/ZKlP8oBtebt?=
 =?us-ascii?Q?eJnfDwVArbC2R54bai64iii8sh0jTTadWP75b858AYFvtzM6fg/zVMKZaY+2?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecf4895-e65f-4a57-2695-08dadd7ea0a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 02:55:16.2478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/Hz3H96BTRYae4hzlEhDswDbSS6J/7wFWEYYdyp1cvNwI0XxWRzvrx+kh9kr8WomrhOUJoHvDJNiQk7TsCbDatdoRHbTHqoazRqD/RPd2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4343
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=918 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212140021
X-Proofpoint-ORIG-GUID: 2_6oDSjrs1A65HYlO4E0ls_EQLP8GCJ8
X-Proofpoint-GUID: 2_6oDSjrs1A65HYlO4E0ls_EQLP8GCJ8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


Michael,

> storvsc_queuecommand() maps the scatter/gather list using scsi_dma_map(),
> which in a confidential VM allocates swiotlb bounce buffers. If the
> I/O submission fails in storvsc_do_io(), the I/O is typically retried
> by higher level code, but the bounce buffer memory is never freed.
> The mostly like cause of I/O submission failure is a full VMBus
> channel ring buffer, which is not uncommon under high I/O loads.
> Eventually enough bounce buffer memory leaks that the confidential
> VM can't do any I/O. The same problem can arise in a non-confidential
> VM with kernel boot parameter swiotlb=force.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
