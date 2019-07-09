Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1BA362FEF
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jul 2019 07:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfGIF3c (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 9 Jul 2019 01:29:32 -0400
Received: from mail-eopbgr820117.outbound.protection.outlook.com ([40.107.82.117]:5824
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfGIF3c (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 9 Jul 2019 01:29:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRcnB1CBXkBWi77NPBkqAziePtP3fg5YfAWEHSf5SfKcPeE1R8VvXAfaFkMH6rgrB/enDEyhHx9QbHex5ZndLb3iERrZNv97qo7kw+EBfKYoidBGBnRCI5fLwnpReUzIwI26wiLxdVSeiVhQGl21aC6yALjAMn8K/1h60a2/8bln87/IxxwI3KUlbIRXsvp4yDiGIU8ahZoMQayAQ/Bll0s08RvceGrFZbV6KAcy2jr0/BXzoFo5GgOLPulMYu7V5C6qHNY0oWfUf3W5mEDjd+oYudLoc/pVTMUG68c/8JiZG1t7kJsRP9y6qlUN3qkuLNlQuh44vs7S51bTpPE4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXUkXvtvlEenNue6M9wdKVErAzzobWwt37/aGBCIdMA=;
 b=VCCyklmPEyROzHbDJZKfQtM0eQOiclSFweQq+r4L8Tet1iNVmdQ3qRqd8HnXN95c4F04IMXvPyx/kA/7CwKAAwdg3o3+muyQo8H9UxTDXqz9al4xOFLlE9kefowrJsf99qGmn/3auQcyIkAEvEku+gZwh4dkMVHGMowiLUP+IXrV69hjp3QT+edljHiVlycdQQkgK1RxhUH9q3ckaQ+ccq9CG8pH610N3LMhfb5guSK7hpd53WOSUAznWqXJiUpHyxs2jPjAxIWMK1hV79XotPNlGxj/mYcWFLDPbDmL1yKDhkUtHDGMzkr8hmUJ76s02uForw7ngDbkeUT16O1iZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXUkXvtvlEenNue6M9wdKVErAzzobWwt37/aGBCIdMA=;
 b=n1g7kulZYKVfI6eDFXXLw8sn023Yki7jFjWuJks1t2/oQJ4et4Yhrxen09esTbPgZ6vjvLr+x165uISza2UdjAytVwREnSeZ4ftpq7+wv2vRWVJfzx9PVT/PJOUoAl/uASu2ZpUV+pNj0pO4InWBV90CY63nV8uR8BW7uAAMYec=
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com (52.132.114.19) by
 SN6PR2101MB1040.namprd21.prod.outlook.com (52.132.115.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.3; Tue, 9 Jul 2019 05:29:24 +0000
Received: from SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab]) by SN6PR2101MB0942.namprd21.prod.outlook.com
 ([fe80::60d7:a692:61f4:e6ab%3]) with mapi id 15.20.2094.001; Tue, 9 Jul 2019
 05:29:24 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 0/7] Enhance the hv_vmbus driver to support hibernation
Thread-Topic: [PATCH 0/7] Enhance the hv_vmbus driver to support hibernation
Thread-Index: AQHVNhdEG0Y6HDaVgkSGCPzVpzmW8w==
Date:   Tue, 9 Jul 2019 05:29:24 +0000
Message-ID: <1562650084-99874-1-git-send-email-decui@microsoft.com>
Reply-To: Dexuan Cui <decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:301:4c::22) To SN6PR2101MB0942.namprd21.prod.outlook.com
 (2603:10b6:805:4::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [13.77.154.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa2d7ec0-af32-4822-1ef3-08d7042e6702
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR2101MB1040;
x-ms-traffictypediagnostic: SN6PR2101MB1040:|SN6PR2101MB1040:
x-microsoft-antispam-prvs: <SN6PR2101MB1040EF82DA108332C4FEAF8FBFF10@SN6PR2101MB1040.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(6436002)(10290500003)(43066004)(2906002)(2501003)(4720700003)(316002)(54906003)(110136005)(6486002)(22452003)(64756008)(1511001)(66556008)(256004)(66446008)(66476007)(478600001)(73956011)(14444005)(476003)(66946007)(52116002)(66066001)(305945005)(8676002)(81156014)(81166006)(5660300002)(486006)(4326008)(36756003)(6116002)(3846002)(71190400001)(71200400001)(25786009)(99286004)(8936002)(50226002)(107886003)(10090500001)(2616005)(6512007)(14454004)(26005)(53936002)(68736007)(186003)(3450700001)(7736002)(386003)(6506007)(102836004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1040;H:SN6PR2101MB0942.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dVRWq2cfK14KW6+rIza34f6wAc9vHibK1vhvb/Ui8dm+fK8NOzQUPF8Eb9Z2nazo8tdoXee75sS20JDj8LlqCojQlFhvbfxHyN05ZBuxRlDotDTpbzwyHThuZsRdaF7qqGbK6n7iQ0lwPXsIOYp0W+2wsySxZba3ssdK8PPv4n16UOUAxyS7TkAnGVSwTk0UUHAxVFNiLDn69chlfI3qO6auHisif2w8WLKsRA0VmQ0nWgCrR9AXY+MbDfOj6lJXFTPnZNLxaYiX/EUoaL6jfj13ad1kBrPlJF+FVOqbnc2OnYJtFiWTmGVEBOtfxTCdTBJvuGAk3uNHjDLVD12OogAk6pYnZnQNsoBHQFrYRV9xbw4iewwDlM8yp+CHVDeticESLTmIxAS9IEeL2ESramoUNWDwq9+D+oI2joihmnA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2d7ec0-af32-4822-1ef3-08d7042e6702
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 05:29:24.3421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lkmldc@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1040
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi,
This is the first patchset to enable hibernation when Linux VM runs on Hype=
r-V.

A second patchset to enhance the high-level VSC drivers (hv_netvsc,
hv_storvsc, etc.) for hibernation will be posted later. The second patchset
depends on this first patchset, so I hope this pathset can be accepted soon=
.

The changes in this patchset are mostly straightforward new code that only
runs when the VM enters hibernation, so IMHO it's pretty safe to have this
patchset, because the hibernation feature never worked for Linux VM running
on Hyper-V.

The patchset is rebased on Linus's tree today.

Please review.

Thanks,
Dexuan

Dexuan Cui (7):
  x86/hyper-v: Suspend/resume the hypercall page for hibernation
  clocksource/drivers: Suspend/resume Hyper-V clocksource for
    hibernation
  Drivers: hv: vmbus: Split hv_synic_init/cleanup into regs and timer
    settings
  Drivers: hv: vmbus: Suspend/resume the synic for hibernation
  Drivers: hv: vmbus: Ignore the offers when resuming from hibernation
  Drivers: hv: vmbus: Suspend/resume the vmbus itself for hibernation
  Drivers: hv: vmbus: Implement suspend/resume for VSC drivers for
    hibernation

 arch/x86/hyperv/hv_init.c          |  34 +++++++++++
 drivers/clocksource/hyperv_timer.c |  25 ++++++++
 drivers/hv/channel_mgmt.c          |  28 ++++++++-
 drivers/hv/connection.c            |   3 +-
 drivers/hv/hv.c                    |  66 +++++++++++---------
 drivers/hv/hyperv_vmbus.h          |   4 ++
 drivers/hv/vmbus_drv.c             | 122 +++++++++++++++++++++++++++++++++=
++++
 include/linux/hyperv.h             |   3 +
 8 files changed, 253 insertions(+), 32 deletions(-)

--=20
1.8.3.1

