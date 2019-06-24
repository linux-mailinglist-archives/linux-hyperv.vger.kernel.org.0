Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C32E51E56
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jun 2019 00:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFXWcO (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 24 Jun 2019 18:32:14 -0400
Received: from mail-eopbgr00050.outbound.protection.outlook.com ([40.107.0.50]:23877
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726388AbfFXWcN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 24 Jun 2019 18:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XN4+lVoQ+cOhCtCUzOmlmlY7AZq9vD0eMs1RW46yp0U=;
 b=LXTAztfnnZaR4vCAyWym15Zi67JPdOiy68GR6Ut9fLjhk7/cnBrXMD6wChzl1NsVVKObJPPVfNq/1mWSxCrIw1s4NQVIz0IxVnl0uohzCf97P9HGqB5mJZpm0whZ4DWrdmyVZVXBq9+w+cWG2y70Ra3TfKLDjMt8Tq1Du/5IVvM=
Received: from DB6PR05CA0014.eurprd05.prod.outlook.com (2603:10a6:6:14::27) by
 AM4PR0501MB2337.eurprd05.prod.outlook.com (2603:10a6:200:53::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Mon, 24 Jun
 2019 22:32:10 +0000
Received: from VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by DB6PR05CA0014.outlook.office365.com
 (2603:10a6:6:14::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.16 via Frontend
 Transport; Mon, 24 Jun 2019 22:32:10 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT055.mail.protection.outlook.com (10.152.19.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2008.13 via Frontend Transport; Mon, 24 Jun 2019 22:32:09 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 25 Jun 2019 01:32:09
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 25 Jun 2019 01:32:09 +0300
Received: from [172.16.0.6] (172.16.0.6) by MTLCAS01.mtl.com (10.0.8.71) with
 Microsoft SMTP Server (TLS) id 14.3.301.0; Tue, 25 Jun 2019 01:32:06 +0300
Subject: Re: [PATCH 5/8] IB/iser: set virt_boundary_mask in the scsi host
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        <linux-rdma@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <megaraidlinux.pdl@broadcom.com>,
        <MPT-FusionLinux.pdl@broadcom.com>, <linux-hyperv@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190617122000.22181-1-hch@lst.de>
 <20190617122000.22181-6-hch@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <bbea1029-e434-a633-5516-fe6a92e60beb@mellanox.com>
Date:   Tue, 25 Jun 2019 01:32:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190617122000.22181-6-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.6]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(2980300002)(189003)(199004)(2616005)(65826007)(7416002)(486006)(16526019)(26005)(77096007)(126002)(336012)(446003)(476003)(54906003)(16576012)(58126008)(23676004)(2486003)(106002)(356004)(7736002)(305945005)(229853002)(47776003)(70586007)(2906002)(70206006)(8676002)(81156014)(81166006)(65956001)(65806001)(67846002)(478600001)(230700001)(186003)(50466002)(76176011)(64126003)(110136005)(316002)(11346002)(3846002)(53546011)(6116002)(558084003)(4326008)(86362001)(5660300002)(31696002)(31686004)(8936002)(6246003)(36756003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0501MB2337;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a4a9614-d169-4a47-9da4-08d6f8f3cbb9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:AM4PR0501MB2337;
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2337:
X-Microsoft-Antispam-PRVS: <AM4PR0501MB2337CA366F2AA78E17D1EFABB6E00@AM4PR0501MB2337.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-Forefront-PRVS: 007814487B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: LVuO0N6wtddtvKl1LL1Z73/Uzmeh7Kv2WF8quQAsWAJfWXUYwhtg1/66+IruTRauyQlfWSTFUNTyrj60P3lt2W5XbrHun4QiwOqN9XEITaRtPTVKX8OrUUliTvLan/H8ZCV3LZ8DVf7fPivFeYy0eiyuXbsD0wAb+herqMzHNEHHs5u4xqSyZXU9ss7or4RyZT6Qs+YEFD7YNIOQrAQkiP6WZcAlrKkqF4x9/16b8l+TR5Z7a09oovg9C4PHJ/LVImEvPzi3EBqFr6heiPgPdIgYiPAkMH76oNPjkrh6gRE+DPnsPEMJc7ubpVPnjIewV/HinJVvrK96VRsmG1jb9wYjawm5NdcUW6qhbXv8leoMOXRomxWZAQTQaLf1GvPG6PO0Ak0K7uQOmSZK4lx0eWZUe9k4Wx6xTa26TiiDpvI=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2019 22:32:09.4232
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4a9614-d169-4a47-9da4-08d6f8f3cbb9
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2337
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

