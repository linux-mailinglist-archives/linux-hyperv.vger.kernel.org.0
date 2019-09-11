Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5644B05FF
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfIKXiU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:38:20 -0400
Received: from mail-eopbgr690132.outbound.protection.outlook.com ([40.107.69.132]:35718
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726525AbfIKXiU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:38:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCqsY9THWs/nBgz+zFLL3ihiqBQtWzO2iyFeLOU56BIgt5L9yctBquoNBeZa77UQr2kPzAWi4Z+G0P5uxQjsOdFsaKK7N/zq3sB+tRosKXMndLNPd1nwzeR+lvesgOWbwiQqlGbc85ArI2swAOAecIZbHvm4s6WcTHqsSuEKpTad5RfuJJUN289BFMyGBIqWYtyTxAw6TlXRuNgREyneaV4Notm1YjM1DGQJaCryiKo03Dw1wN9r9eKhuK+kjGwltFz3mLVOSkAT7U70wVvjze5YPTfq5IiZpN/jMCm4Gsc9cT5RoLOcssquSgpJeGegcrViFAA7mfpYGCnmxfgSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQzneUZntFqm2MfzJHuhHO52Bu2qXFb3+Y+kAuXdeuE=;
 b=WhpROJ++yL4KqoJHKfjvI8k6H5SiBumg5x76IKw6dZGKEiIoWfMNMsP5dW+adz0TXhKbJXFYrB/9FD9k24kkVs+QYE5Q43/3DA50wNdMypg3pZIyoiAhbN4xZP7iJz9Fjr2ChXbQPqDYH2U9G7kw4KummupvYqVtviNKPOMQcclwQvgVdfhvpOiFhG1EnzSJ/kdIa2/W1FvwZuRO3zvMUf5fZHk3M8CnnUPKyfU6us+dUfVBj9tfPM7k5wSWiChr0vry0GKL+fTIIyeWhs5Z3touyyakGkxPy0qna8W3BxP/+tnBFtxORkaihS2WafbIsKpEzIwp5gXHf4UhexrLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQzneUZntFqm2MfzJHuhHO52Bu2qXFb3+Y+kAuXdeuE=;
 b=j0Z7kUhEjRa9Whp7NMevmzZcxRmpmaslqPr7XG1oq7MIsxwrqzI7Rf9uLc7mcuXJWwtoX5XGkbtjR0HvERDQG+UMFZX8XEMvJu4KFXrwCzYK6CMrBtLb2uAc3mukyBOrntyEuafJfwFMGC9bAZpJ3sLokzsylfUKIw+LZtz0ygQ=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1087.namprd21.prod.outlook.com (52.132.115.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.7; Wed, 11 Sep 2019 23:38:17 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:38:17 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 0/4] Enhance pci-hyperv to support hibernation
Thread-Topic: [PATCH 0/4] Enhance pci-hyperv to support hibernation
Thread-Index: AQHVaPn8vIIXMuXG2k+dW/CDPjDTsg==
Date:   Wed, 11 Sep 2019 23:38:17 +0000
Message-ID: <1568245086-70601-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0072.namprd19.prod.outlook.com
 (2603:10b6:300:94::34) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ea10a0c-23bd-498a-1610-08d737111efe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1087;
x-ms-traffictypediagnostic: SN6PR2101MB1087:|SN6PR2101MB1087:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR2101MB1087AF4AE9AE2C818D778A21BFB10@SN6PR2101MB1087.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(10290500003)(2201001)(2501003)(256004)(7736002)(4744005)(6306002)(6436002)(305945005)(2906002)(14454004)(3846002)(2616005)(81156014)(81166006)(8936002)(50226002)(66066001)(26005)(8676002)(5660300002)(966005)(110136005)(6116002)(316002)(6512007)(66556008)(186003)(66946007)(86362001)(66446008)(6486002)(64756008)(66476007)(22452003)(71200400001)(476003)(71190400001)(107886003)(43066004)(25786009)(478600001)(14444005)(102836004)(6636002)(99286004)(1511001)(36756003)(4326008)(486006)(53936002)(52116002)(3450700001)(6506007)(386003)(4720700003)(10090500001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1087;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c6WmyEUGe8zOEWLaghTlGYhu1oq6r+0u38+hkxKkeWz7DSQ9pPXBSbP3pHCibBxTHOqamXgae6uwNP3GA/3UohZNasGTooqr9gfpQq/UXVBCOst0TiN78/CWhWAxQNNIMKmOxxgnYblxg5GjBggpQY/AwjCSduFVKHli/2Gwy6/8c2Hv4UKEOWo87xwJK9YC/JQQfoZO1jvsgWyDRM2j8h515wnm1bJZG8KUZriNH0jGjAX+N5TovRgMSSgvLqwd5LBAhRLqRKipXiDsHK5qrirK3gzKLtJbecl7z2pJBxasFCAgxSgGjCeyLTtcFV/E+F7V/Z3DbI/FJQBOsYwN043PcSymMyhjMmfvzBX+eGBNcjo0LDzLzypeHm+1cTy8NrbXPvzd6wlmZH3bcK0rKVBNZfmA4nsfl3LbuY/ztlU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea10a0c-23bd-498a-1610-08d737111efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:38:17.3072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqCL35eoow8eAldbxlmLxhrZvK2fhvL8MTUhKEsFWejB0FkKgr87YnvgGNJzElfVFHZMul26YsnsQkiDtU6kTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1087
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patchset is basically a pure Hyper-V specific change and it has a
build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next

I request this patch should go through Sasha's tree rather than the
pci tree.

Dexuan Cui (4):
  PCI: hv: Reorganize the code in preparation of hibernation
  PCI: hv: Add the support of hibernation
  PCI: hv: Do not queue new work items on hibernation
  PCI: hv: Change pci_protocol_version to per-hbus

 drivers/pci/controller/pci-hyperv.c | 166 ++++++++++++++++++++++++++++++--=
----
 1 file changed, 140 insertions(+), 26 deletions(-)

--=20
1.8.3.1

