Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA23AB0610
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Sep 2019 01:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbfIKXjA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Sep 2019 19:39:00 -0400
Received: from mail-eopbgr770133.outbound.protection.outlook.com ([40.107.77.133]:6560
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728482AbfIKXi7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Sep 2019 19:38:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRKkBFpWd4z39OD1o0zzL0bvc0hlwLx9IWYjF42/zBi37f4AKD0Zgod2r1KtN5lwW0SPVhwjhyjzYz2sSr8w3rUac1PEZW5+ImlbKZFKOXhP30E2Fh7+WgBTfV71EqdtVx2rswR8jHuHriQPosm1LYK1In595JZ5a0V/P1A8yD02lb89SzSLJbxPH4RtjJVRWuAPA9rN2vcNBS2ymobcJ3LoGfh5mxnGMO3a4cq7NM/wUW/jjpKo+8ssJW/y47Q6zXMneoOsAKkQ+kW9ZQHXd2UEbqSc+3aR5OfEOzzO7Vn/Dype4ktM0oLfitbAlhA0rB0hsckNJa7tAMQt6vRGaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfzQ+S1LFQstA6YpWNBa6ztx4Np4hutBvJf/mfHaxMY=;
 b=ZG+ZLPSP1td+EI3PBYxJe7WmKftCTteaeiTOQsSucrBsRE+OMzmEI7+SXsIvz8SrIuTCfwt7LoeJOl+neykbEQpKEMfOiP81Nv0RZEl7MLIDMZuY/mvRW16umaE9OWz+ZjJshUdOywEOFcd/yiWw+0zZGSKUt6teckjmbmQviYLIpMZL32pxtNRrivIf56gAQIeb3EL/2Sd9fjbPQX0leukSudihG+j0/t8VeI+25qba2jr2k8/nhgbG2c2SFi3ar3kx4D3+aKs0Xlfu6d0H84mb3/a0Xc00DoXKcNgqtps+XDEqp06AXqgT3Tzs3gYFhHyxcyeqTrneAwuwen8I3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfzQ+S1LFQstA6YpWNBa6ztx4Np4hutBvJf/mfHaxMY=;
 b=cgYWBxdN0IsP9v00p9Eeq1Syb7acBc0tJlevyowmoX0v/mR00Vc+yVHfgSLLptI4Z1eD19VjhAX30fYEHYDsO0EToQjxttli7ps5vWljW5PmS3mroLKa5Z/8yJxs1HrA6YqLZmcDfvYTePOoPMn/ywSI60V8H1lzsNeT57T97MI=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB0909.namprd21.prod.outlook.com (52.132.117.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Wed, 11 Sep 2019 23:38:57 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::dd56:aa4f:204f:86a4%3]) with mapi id 15.20.2263.005; Wed, 11 Sep 2019
 23:38:57 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
CC:     Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 0/3] Enhance hv_utils to support hibernation
Thread-Topic: [PATCH 0/3] Enhance hv_utils to support hibernation
Thread-Index: AQHVaPoUrrCXReFM+EyLYq1k4UhZzA==
Date:   Wed, 11 Sep 2019 23:38:57 +0000
Message-ID: <1568245130-70712-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:300:c0::33) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb8741c4-4f27-49ba-e37e-08d737113708
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB0909;
x-ms-traffictypediagnostic: SN6PR2101MB0909:|SN6PR2101MB0909:
x-ms-exchange-transport-forked: True
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR2101MB0909B8C0CE44BFE7243F3FC2BFB10@SN6PR2101MB0909.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(189003)(199004)(3450700001)(6512007)(6306002)(486006)(476003)(2616005)(2201001)(14444005)(256004)(6486002)(86362001)(36756003)(5660300002)(186003)(4326008)(4744005)(102836004)(6436002)(53936002)(25786009)(26005)(107886003)(10290500003)(316002)(478600001)(2501003)(43066004)(52116002)(14454004)(386003)(6506007)(110136005)(66066001)(99286004)(1511001)(22452003)(6636002)(4720700003)(71200400001)(71190400001)(305945005)(66446008)(66946007)(66476007)(66556008)(64756008)(50226002)(966005)(10090500001)(7736002)(2906002)(81156014)(8676002)(8936002)(81166006)(6116002)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0909;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NSKm+dZnc7OdexVhmLg5641FqcpF2dkI2ZXHnNcLspC+D7/uIdS5tOuxa1P+8i8M/G0rrrukxP4DGBwNx8tDcLZXyWepw5gqLozxarHPo2lDJI0a3dmJekeLTJXfZmapB94EMWRnIddYXtk+YlO3Zcseop91NlZtZ0hg5WTXUx5CwWrQzcjM2a5LL1H1FzUo7CAUXEOrFgjEGXNw4MmV/Ji/W2nktx05y6XQucNZ0SaJNk6yAj4BtMhq3NBuTvZ5Mew1WNo1YkGI9nDyj5U4ooPg9IXen9EWtX+d6PbM/zD1W/OGH0rY07e9gHTf7iY/iFjxu76XOtKojXR17QUxT55N0oM5iOcFOx7CPoTRt97MW8aIKEb4wWVr5qOWaGWUO/sA/ohwPNBQp/JbWyT9AEPESCOiJ+KnkYefxdsUTro=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8741c4-4f27-49ba-e37e-08d737113708
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 23:38:57.6054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jc3grRnTnAA+4tneEC+y1j42KWuSAQDB4vyE9H+A62+ovq7leqLi4o8H8/2x/F6iOhQ7uahEzE+zc0RjR9BijQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0909
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This patch is basically a pure Hyper-V specific change and it has a
build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus: Implement
suspend/resume for VSC drivers for hibernation"), which is on Sasha Levin's
Hyper-V tree's hyperv-next branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git/log/?h=3Dh=
yperv-next

I request this patch should go through Sasha's tree rather than the
char-misc tree.

Dexuan Cui (3):
  hv_utils: Add the support of hibernation
  hv_utils: Support host-initiated hibernation request
  hv_utils: Support host-initiated restart request

 drivers/hv/hv_fcopy.c     |   9 +++-
 drivers/hv/hv_kvp.c       |  11 +++-
 drivers/hv/hv_snapshot.c  |  11 +++-
 drivers/hv/hv_util.c      | 124 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 drivers/hv/hyperv_vmbus.h |   3 ++
 include/linux/hyperv.h    |   1 +
 6 files changed, 152 insertions(+), 7 deletions(-)

--=20
1.8.3.1

