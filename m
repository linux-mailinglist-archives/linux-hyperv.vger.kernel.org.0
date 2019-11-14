Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBAFC039
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Nov 2019 07:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfKNGcE (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 14 Nov 2019 01:32:04 -0500
Received: from mail-eopbgr760091.outbound.protection.outlook.com ([40.107.76.91]:6663
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfKNGcD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Nov 2019 01:32:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvp+Y1c6foKhNOlJOnAhbR7uIFKkbLi8XFd1IXjp9ueEHTkPvUPzphB9px/XLwkBBHTP9DJiaxLhxJjHCHvETPFA9fq8nBP4Xx98W76e8139GnJg1VW+FgB5DnywJ6cRb9IEVRxgnT4MGoqzG0rPgjP6l/KVM7njKpjLspwVcpS/w3oufPC7iW/vKacNqIXWlRBHkG9vfEaw0lU97KTIPGBADQDJdPCNKDIdzCipvkE9DG/nC5/bZtwspU/+6EotZgkzih3gITiZPsx9UEZ2KCXGtk2/9/Z2k6X9nvekaLXMFzFSXoZJd/J4DbWsL2PnzBwjXW8i2+dNoGGBdW7l+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDHuNW93JB973wrTc2J4fycn3UqUfXH6kgsLTkwslls=;
 b=RYiCxIbaGyt3ySiP8l7JCAYnfjC75AIi2Gsf5+UPOspjw8ZOdD7Rb/oE+s4RYCKNqbcn9ozYjtnOqdoXOT6856rDhSrb22snVGAvylYCgKG6MEaTMPBA2I9A8eYXYXHXrfIh4pg6VjUe3X8U7RsRxq0jnGXzTTdQrwF+SavhQp+dyrEFMLd73ik+WMrjf9Ou8ZFkhyR4BvBi8u6WaC5R0IUxj3FppuB2/IIbG2C5q6VQ3iAChuVp8Gp5aqRznfdAAcIMShrc1w1OA4dSypnrpSFASaImy5OiCw5R1izrcjPAUObYKZ0BrRTPRSj/QvkPCoTLatmXY+iXuiGkBN6Bmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDHuNW93JB973wrTc2J4fycn3UqUfXH6kgsLTkwslls=;
 b=TZqXmc2xjLS61TXfw021F1xVTyQEH81RbYJktL/CVvgDHnmnv69wCMTW5oR/TctoQDtUSyMGOd/0/1RXpKD5Jj8S0VWh6u2n2I9VFx8l90ixHtVUBhBPH6tdOnJt8DMI4h7Z4SN30QCLTiEXcUf5IsYMGHRvIPxpw5N3il+Wznk=
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com (52.132.114.24) by
 SN6PR2101MB1021.namprd21.prod.outlook.com (52.132.116.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.11; Thu, 14 Nov 2019 06:32:01 +0000
Received: from SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::185e:548e:7cc4:942e]) by SN6PR2101MB1135.namprd21.prod.outlook.com
 ([fe80::185e:548e:7cc4:942e%9]) with mapi id 15.20.2474.009; Thu, 14 Nov 2019
 06:32:01 +0000
Received: from mhkkerneltest.corp.microsoft.com (131.107.174.247) by CO2PR04CA0068.namprd04.prod.outlook.com (2603:10b6:102:1::36) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 14 Nov 2019 06:32:00 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 1/1] Drivers: hv: vmbus: Fix crash handler reset of Hyper-V
 synic
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: Fix crash handler reset of
 Hyper-V synic
Thread-Index: AQHVmrU40YXv2apLdU6NdUllgrDfPw==
Date:   Thu, 14 Nov 2019 06:32:01 +0000
Message-ID: <1573713076-8446-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:102:1::36) To SN6PR2101MB1135.namprd21.prod.outlook.com
 (2603:10b6:805:4::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [131.107.174.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 277eff01-04a3-4207-96ad-08d768cc5b2e
x-ms-traffictypediagnostic: SN6PR2101MB1021:|SN6PR2101MB1021:|SN6PR2101MB1021:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SN6PR2101MB10213A71887901054848890DD7710@SN6PR2101MB1021.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(376002)(396003)(136003)(346002)(39860400002)(189003)(199004)(5660300002)(4326008)(26005)(6436002)(6486002)(14444005)(256004)(66446008)(107886003)(66476007)(66946007)(66556008)(1511001)(64756008)(71200400001)(71190400001)(10090500001)(3846002)(305945005)(6116002)(25786009)(2501003)(10290500003)(36756003)(52116002)(8676002)(386003)(50226002)(102836004)(476003)(956004)(81166006)(81156014)(16526019)(7696005)(316002)(22452003)(478600001)(7736002)(66066001)(4720700003)(2906002)(110136005)(486006)(86362001)(8936002)(186003)(2616005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1021;H:SN6PR2101MB1135.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n34+qtroTh4yk7dScZlCqHggauq5Q1TBjoIT9g3o91cv1vpiUSNZKIrVznHLCxACjzNsxys28D6GX/2MaTEv4GvXaw2zcz4FO0oXKOJdORaobiTM7iQ5yzveSLtQY/gZNetgjoOkZKJZa3sI5CrAqAh9mE0qRJ9MiPVDR2sYyPky+BzW6ykUs3vJeCqUGKNRhNXVqiq0D0qCBdhze+zQB1HAjYV3TF0YBVaTfclzvYZByPJKLaICHx+yLZFBUatCCRsS9aa/cwCjloUUAa6MjR5uiT3dgDa+oaOv2sO3b+FVDHQwN4oijwtRCB9sRLvB8del/hZ+frIr8GdbWuFg0JVY1i/sh8x7zBDexMBfIdkUhcj5pw5ftg8wmZ9lOYpvTFYnyDWsaF4Q7N0nNiWbJavJkMy0PDQ3A8gTi7xvs8adR0Grw/Tfv4oeB9PisTp4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 277eff01-04a3-4207-96ad-08d768cc5b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 06:32:01.1449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FPPxfT8iEnG1nbHpnAnd5DkV46mq0OC0rgyWpHkk9ecfBIzaIJdfk8FLL+BMnQwdRCWkGqFMLqkpU1dFUI+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1021
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The crash handler calls hv_synic_cleanup() to shutdown the
Hyper-V synthetic interrupt controller.  But if the CPU
that calls hv_synic_cleanup() has a VMbus channel interrupt
assigned to it (which is likely the case in smaller VM sizes),
hv_synic_cleanup() returns an error and the synthetic
interrupt controller isn't shutdown.  While the lack of
being shutdown hasn't caused a known problem, it still
should be fixed for highest reliability.

So directly call hv_synic_disable_regs() instead of
hv_synic_cleanup(), which ensures that the synic is always
shutdown.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 664a415..665920d 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2305,7 +2305,7 @@ static void hv_crash_handler(struct pt_regs *regs)
 	vmbus_connection.conn_state =3D DISCONNECTED;
 	cpu =3D smp_processor_id();
 	hv_stimer_cleanup(cpu);
-	hv_synic_cleanup(cpu);
+	hv_synic_disable_regs(cpu);
 	hyperv_cleanup();
 };
=20
--=20
1.8.3.1

