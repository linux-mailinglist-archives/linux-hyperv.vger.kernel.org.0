Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 471341A4A72
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJTbk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 15:31:40 -0400
Received: from mail-dm6nam11on2129.outbound.protection.outlook.com ([40.107.223.129]:24288
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgDJTbj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 15:31:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRIiumR+ir32ZgMuXP43NXtL/AkP8NI+BsVebPdoutsx2NvuTU1Z76XEL1YiVseFHHz4eDsCCtOZifeego0/wAubc6VqAXx8SmZSmxwRgHUnxjJAmd5v00KTv8PxkyIQlxQwjnJ9kKm2T0bgfzbOOb2EJi/33iTMtUIx75rb1Gn/oWQ3XKl0L9Lx5Jtj8TUDxtWGs4imCzmBoD/s0qFzqe/Cht553CLF0xFOoxzQRx0EyryDowm3iETK6TGRjG3ZLfW6temiukcPpvI+Ke+KQM85X5TDdq+OCkYZPbevjyE4JN4l0UeuQRUQp6mtJ6tBGxdQxP4P8eTxEi1uFB7Vwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZTaRlZMJMn3in3oT8LhVAjPMdBclBSTRlPKH/RhUB4=;
 b=QATWJeMICmwbK0eJtLia5szFKL1scIRfNxCouYTnN7jIAzvKfTzbPoq08JLYdBvs5OrY+nQYzVWkB3w9flJarAX6gue5LoYxmJsIQllzicrd+7BrblXlnTmJRXD7AouF/qAdCw2Yj1/mGQ11KqsyNhLWT/3D5043qAQjh+zbeeLyFJBgSdtruYctdKuNAYkFWb7dSvnA2N1e2RJdMHM0Xa1bjjDjNuQLQh9Gmyxo7QFOp9SuyV4W5NhqQQhYdQDsfil7Fh9yHoucuS9rmoNSKYC9xez3NVlZ2uCV1vsOOLxuMo4//WW0oLytum09apk9ZdYuVrPhdD07XFKbYdf0OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZTaRlZMJMn3in3oT8LhVAjPMdBclBSTRlPKH/RhUB4=;
 b=WqW85ipPx+VDaw1LSqtv0TJvWTWPLcO1HwPj7sj7BuPsivA3ekLV/XHrC92UgSbTBNttUuC3HjmQN7Kp2hrcm0cpDNQ+w0WeqTFrjtwnkLp9E3qunCjudevlogGd4hYnd0d12T3agBb+k1UGiFo+Ccp2JzhE9/FVVZeeodD3pZQ=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB0903.namprd21.prod.outlook.com (2603:10b6:4:a7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.19; Fri, 10 Apr
 2020 19:30:59 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2%9]) with mapi id 15.20.2921.009; Fri, 10 Apr 2020
 19:30:59 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH 07/11] PCI: hv: Prepare hv_compose_msi_msg() for the
 VMBus-channel-interrupt-to-vCPU reassignment functionality
Thread-Topic: [PATCH 07/11] PCI: hv: Prepare hv_compose_msi_msg() for the
 VMBus-channel-interrupt-to-vCPU reassignment functionality
Thread-Index: AQHWC6iwmqmq0/XHV02OvpgTtD27H6hyxUGg
Date:   Fri, 10 Apr 2020 19:30:59 +0000
Message-ID: <DM5PR2101MB10478D5B2E9A9D45CBF9E153D7DE0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-8-parri.andrea@gmail.com>
In-Reply-To: <20200406001514.19876-8-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T19:30:57.4728580Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5d641fa3-9c6e-42e2-8136-00e5c1fe6e41;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f88fcd9a-a23e-4671-6c27-08d7dd85b2ee
x-ms-traffictypediagnostic: DM5PR2101MB0903:|DM5PR2101MB0903:|DM5PR2101MB0903:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB09034E0EB624235DA70A7094D7DE0@DM5PR2101MB0903.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(6506007)(7696005)(316002)(8990500004)(2906002)(54906003)(478600001)(86362001)(186003)(110136005)(10290500003)(66556008)(82950400001)(82960400001)(71200400001)(55016002)(66946007)(26005)(66446008)(76116006)(64756008)(66476007)(81156014)(8936002)(7416002)(5660300002)(8676002)(52536014)(33656002)(9686003)(4326008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9ZuxvjIzs+mbmwn9X8fJ7ZHeZ1a3V/FBx2d9fwaCl1aWzG2GKGenonJ56dPQIUBwzEbHprCQV8dPYPAYsTtpVzmB+0m9qHndR87lvGEO1RaxSkblqFgOiS1YLZMIiAuFbZFlb6xEqyBJ3lZtEyvnznJZZPx9FRW22s5Ppc0xGi6xfDjbRRjD53nRnGixejLKT0o0mZpb7upw9h+39KpIT7gwjSJOsl8CXsnDgQAwto1sv40BbGENFgI6SWTfACpnaVeEGhGIag6Xix9VoCCL17YFzJ9DPswPffwxXEOwHZwouoO3FHQ0TZ8Uuc7rEjaiqMhx7pd7d40w/Hko6TiLwMOB5m8gLRIPo5Dn7xNXQRejTvD07Cj9d3qrDzBVGoXdzxEZRT0fTIegYmC49oQgvzUMWsTacpNG9g7a90zXRLbNdrdIyPGBktT5VLmTKdx
x-ms-exchange-antispam-messagedata: lmiXdbvmhc6tVj2yfyGbcEhAPvXZuQ4Sn1yDmsn+GN/PZQ+qgDcY/a7eOEssSLFgrSmSCjhkDiofryV5rV1cqTpUertKCKnxKb3LTZVcXi4HCSd9VyZStr0cx2NXbB7iSpGRwKaP7vSb62OmyzgQBA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88fcd9a-a23e-4671-6c27-08d7dd85b2ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 19:30:59.7144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PbrxALvgMrTdjk1/1dyqsVGGfP+9nUYsM8rMoNLYQoI3LSfQqYLLwHiBQdGBJJPYB8oaFuV3jA0wZ0DDHlGROuxgGCkAbqNoswfn6YA+s18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0903
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Sunday, April=
 5, 2020 5:15 PM
>=20
> The current implementation of hv_compose_msi_msg() is incompatible with
> the new functionality that allows changing the vCPU a VMBus channel will
> interrupt: if this function always calls hv_pci_onchannelcallback() in
> the polling loop, the interrupt going to a different CPU could cause
> hv_pci_onchannelcallback() to be running simultaneously in a tasklet,
> which will break.  The current code also has a problem in that it is not
> synchronized with vmbus_reset_channel_cb(): hv_compose_msi_msg() could
> be accessing the ring buffer via the call of hv_pci_onchannelcallback()
> well after the time that vmbus_reset_channel_cb() has finished.
>=20
> Fix these issues as follows.  Disable the channel tasklet before
> entering the polling loop in hv_compose_msi_msg() and re-enable it when
> done.  This will prevent hv_pci_onchannelcallback() from running in a
> tasklet on a different CPU.  Moreover, poll by always calling
> hv_pci_onchannelcallback(), but check the channel callback function for
> NULL and invoke the callback within a sched_lock critical section.  This
> will prevent hv_compose_msi_msg() from accessing the ring buffer after
> vmbus_reset_channel_cb() has acquired the sched_lock spinlock.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <amurray@thegoodpenguin.co.uk>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <linux-pci@vger.kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 44 ++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
