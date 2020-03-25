Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C41E119306B
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 19:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCYSbl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 14:31:41 -0400
Received: from mail-bn7nam10on2108.outbound.protection.outlook.com ([40.107.92.108]:20640
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727275AbgCYSbl (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 14:31:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUCcC82ZMaUMY+vgiOt48e51mJznsDFInhfG+Uk3gzm3Iz5zHPUmUX2IMUv4MZjJgQ/bOP4FceDQs0qNe+7crFgVQa5y0eshbuXUBQux5d5392ldSk1jhQl1xZ1Ui0z22Cj4SnqNSC0RBR+GQyz+dXP8qjUvvaEhcw42wn+RK37s5RnrlGV955ZkmD1YvDRYOjHU5bQfYxZB4IsNCQQWvAEnXR10AaI4Ohf5fzVTHIbQWc2x7uemmreD9XHJGh54gZNpdaIsu9AjEVucVetkkWjiR+3cKNLBtMyR+zViH/HhQBcbGj1FJSYSTYjyGbRCDv/YmbDX7xbFAKbNWQln+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WN7uYoplqTxf+W2u4qTk8j9ZiQ+VgbtNIq+3GAtH5c=;
 b=b134r/Q6PoSqhoA3kX882tXoTXB58iki/BDSdqazc6ppyVq799pMUnHelg9OH/eccqY7gZo9F3WV2i1SYQhboZrxiQv6PwuLfoBQNbprRfT8vsScOHEx+HpoYaR1w58brC+ztQj8Pdw43DBtGhs556rV0l9qCyxabJYbLMrB8TEBY1bfaTi75sxHmaqAcA3MAZLsIx+E8PdJ84w1gY4RLIjartvE9O9CwcukLgUVlvVCiU2H87XPGX2Wi2ujNyW27WlN9VOuEN1pm8Z+YlkhHqumm52nfaLOEgmO3iLuKg/cIQ0FMbNUXsjEv0bDKjeNUht0AFjRL4bbbZAoZ30oBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WN7uYoplqTxf+W2u4qTk8j9ZiQ+VgbtNIq+3GAtH5c=;
 b=PVvDpU8rYV81Oy1wAeivUhJ8kp6/TEyVdZfxlM15g+XPAmiXUGCK7sHM9zI53IxEGhJ8mdXA+FcgGw1Ig6g5c21iQdmAlsYWtL8F1G/HG5bp6owFTXfY15kBq2sxJ2bg40NbbCH2k+YvHnqSf9bImDOavqCrOw5SuMATMVuxt50=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.2; Wed, 25 Mar
 2020 18:31:34 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.007; Wed, 25 Mar 2020
 18:31:34 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V3 3/6] x86/Hyper-V: Trigger crash enlightenment only once
 during  system crash.
Thread-Topic: [PATCH V3 3/6] x86/Hyper-V: Trigger crash enlightenment only
 once during  system crash.
Thread-Index: AQHWAbHkVQqv7848GEyMFXlIMavObahZo21A
Date:   Wed, 25 Mar 2020 18:31:34 +0000
Message-ID: <MW2PR2101MB1052446D68104978CC02468FD7CE0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
 <20200324075720.9462-4-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200324075720.9462-4-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-25T18:31:32.3622987Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=08811a53-9bd9-447b-8942-bc1586d2cc3c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51e35313-bd2c-464e-4dbe-08d7d0eabf2b
x-ms-traffictypediagnostic: MW2PR2101MB0938:|MW2PR2101MB0938:|MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB093864536C24348CC59B31E4D7CE0@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:121;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(110136005)(66446008)(64756008)(6506007)(8676002)(66946007)(66556008)(66476007)(2906002)(54906003)(478600001)(33656002)(81156014)(81166006)(26005)(4744005)(8990500004)(10290500003)(186003)(55016002)(71200400001)(7696005)(76116006)(8936002)(5660300002)(86362001)(316002)(4326008)(52536014)(9686003)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hY8hDnjCls9Br/vNZwaZFbg87dHrUQ7vbj6NyqHc0uta/d3huoIDX4bKsUlbs5pCOuhDatCfygE4xrOwH+JMLb+Ge8oGIp00VB1bpb6vlOu7FhObXUHhSXKhOtE6CIx6dQFEjGAyIb0OrTzosK/gAUoY0Ef8EFKRLpiFPgiURQLDBkvpjds9vDLXTkuGr4n7vVN901Ayh76557E87GmmyKhqRCR1RwKpqGuo0Yec6JX82E714tWnzQlpLivVJPJAcnnECHf/KrOVufouf6elCO6TKdwYvPGNXTmKiDT1ULJSTJLBB56flsqqi04MhV0J8DDpSYI5DEzi4BJ4+9V7S0kEjjy0FqrkP0HsizDptKdvtxTitbRWQlPe1uu3knokuzoqR2ZAodK9e+VX6XIo6Q/LXJ+5i65zbXXVuV2y2C6HHeUVTcfNif3USaPkPLRS1Ub4QFg/nMq/YTobT0iKZ1V7fBYoYnJOJR79OA+/WdXqzzuMzBLplFaeYONV6mwG
x-ms-exchange-antispam-messagedata: uNQoli9O1DIIIHp+LeP2/P4pIrM01ejIp0jRoOFjFqYWpdKi0tsyF6Tvja786lQqGDgTjqG6I9cNjabBFZJFLJI1MB41eVLBADgJElCFDmvYFNe21iYEMlSvxJr1XO+BkqHSUB5CPgVDXm7/T/C11w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e35313-bd2c-464e-4dbe-08d7d0eabf2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 18:31:34.2486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csylkRkBKmbcGoDECElDkgFKO9V2hBSrefVzv6TTOop8SJfJgMLB9amx+/0JIw36Dd0ei0LEY7Dt2XWhDAz+NL2HKX/lQa2dBSeCbqYHOC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, March 24, 2020 1=
2:57 AM
>=20
> When a guest VM panics, Hyper-V should be notified only once via the
> crash synthetic MSRs.  Current Linux code might write these crash MSRs
> twice during a system panic:
> 1) hyperv_panic/die_event() calling hyperv_report_panic()
> 2) hv_kmsg_dump() calling hyperv_report_panic_msg()
>=20
> Fix this by not calling hyperv_report_panic() if a kmsg dump has been
> successfully registered.  The notification will happen later via
> hyperv_report_panic_msg().
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
> 	- Update commit log
>=20
> Change since v2:
>         - Update comment
> ---
>  drivers/hv/vmbus_drv.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
