Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA78551E5A
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2019 00:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfFXWde (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Jun 2019 18:33:34 -0400
Received: from mail-eopbgr50047.outbound.protection.outlook.com ([40.107.5.47]:58946
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbfFXWde (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Jun 2019 18:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wFFYaWWuUevbmSaloUuLSlosgeVtyPpmefuFpmHz78=;
 b=itKtxDwujiFxqWkQV254ZxOORNYZLEai7NTEVVkn8tjlhLqKCpFRBz+Bdtpf+j+LoEtAeU1Ngtpje56dJ3l0oRp0ZhOtz/3ye/7Q4ddURczlYGb5RN3OKUvMuZiRwNJ4BeToIywQQXs8w4kc0o+cq87wq7HKVclcZzz245XCoco=
Received: from AM6PR0502CA0044.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::21) by DB6PR0501MB2341.eurprd05.prod.outlook.com
 (2603:10a6:4:4e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Mon, 24 Jun
 2019 22:33:30 +0000
Received: from VE1EUR03FT036.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by AM6PR0502CA0044.outlook.office365.com
 (2603:10a6:20b:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.13 via Frontend
 Transport; Mon, 24 Jun 2019 22:33:30 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT036.mail.protection.outlook.com (10.152.19.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2008.13 via Frontend Transport; Mon, 24 Jun 2019 22:33:30 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 25 Jun 2019 01:33:29
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 25 Jun 2019 01:33:29 +0300
Received: from [172.16.0.6] (172.16.0.6) by MTLCAS01.mtl.com (10.0.8.71) with
 Microsoft SMTP Server (TLS) id 14.3.301.0; Tue, 25 Jun 2019 01:33:27 +0300
Subject: Re: [PATCH 6/8] IB/srp: set virt_boundary_mask in the scsi host
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <megaraidlinux.pdl@broadcom.com>,
        <MPT-FusionLinux.pdl@broadcom.com>, <linux-hyperv@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190617122000.22181-1-hch@lst.de>
 <20190617122000.22181-7-hch@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2d4774b0-4977-23d1-ade1-7cae900f92ab@mellanox.com>
Date:   Tue, 25 Jun 2019 01:33:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190617122000.22181-7-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.6]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39860400002)(396003)(346002)(2980300002)(189003)(199004)(65826007)(36756003)(47776003)(64126003)(86362001)(486006)(356004)(476003)(478600001)(2616005)(186003)(77096007)(16526019)(4326008)(26005)(305945005)(7736002)(558084003)(126002)(336012)(8676002)(2906002)(106002)(230700001)(110136005)(7416002)(11346002)(8936002)(23676004)(316002)(2486003)(81156014)(76176011)(6246003)(81166006)(5660300002)(31686004)(31696002)(50466002)(54906003)(16576012)(65806001)(446003)(65956001)(67846002)(229853002)(6116002)(53546011)(70206006)(70586007)(58126008)(3846002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2341;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3b33571-05b2-43ea-2baa-08d6f8f3fbd4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DB6PR0501MB2341;
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2341:
X-Microsoft-Antispam-PRVS: <DB6PR0501MB2341239B17FA22012660CE28B6E00@DB6PR0501MB2341.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 007814487B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: SPWdBfbZWEE7ET54OKcd7IYh2oYws2mdFDUNfB8sRJ7MMYLsXHee+Fm+bMWoP1pZO9LXGcnv0g4edaeEvTliU7WHvfFHUgHnV3IPjrwY2KlUobcTUIjFckFbxPR+AzI5IqQUB8z5olxtHUlhKxfCvIo5VblFh1FlXVLrMJ+eIKaMXnw5OldHn6kEu/CjMhgUxM8jn9hG7ZmYQQpwe6cSF68k/iY6ETtRZaoLJSWZCVMpP0qkSuydy9DYYzMCAkMimGnAjvw2h9+hKT/nnBCzN58pBb7yr863oi7EgBEmFJRCM0pZo6hTONMGevhx1lGNYz81VCMKCZVwtqARslAZvCWdpZyWjiWwb44iANWaDFE/wgMH84MQyNBJwY3L81yT4kbsnJUWubNSYwIHaZZ+5Md9NPt2ijfqJlHU0tom/Nk=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2019 22:33:30.1278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b33571-05b2-43ea-2baa-08d6f8f3fbd4
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2341
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 6/17/2019 3:19 PM, Christoph Hellwig wrote:
> This ensures all proper DMA layer handling is taken care of by the
> SCSI midlayer.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

