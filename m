Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 623ED15B87E
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Feb 2020 05:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgBMESL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Feb 2020 23:18:11 -0500
Received: from mail-eopbgr1300109.outbound.protection.outlook.com ([40.107.130.109]:8416
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729633AbgBMESL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Feb 2020 23:18:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftCPQbXhlsOzfJtPPsmxl/d43JNxqv6pZpSFD0a4Fz9iMrS/xOyCVMTmZFjSsvRlFjuiRLQG+oe38nLKtsWpQyjRAjnVdILo5M2mWY1lQ9FzYPvBakZi2utJ96SbphiShBhJ5AIXTmWiuid3w88ssPBuVGUJq3e6BJ+64xKleOq5jxe6DNVCpBSXBiwF0e3ukj7aMmkSVKxh9cRRwcPLBVYw3dTP1OSjEVuXXXl29Hz3pUvzPMWqmRghPOS6ZtaJRqoHT5dxV2aC+2gggxBMNUHluOMWIhsNuODuOzY/aCX8pjiKPjNG/hmkAZyD9crA8vMCv+CJ1u8bzOPcHIa/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGTIQeg0+eKDbwcVyrM63ya+ly96ipnAwkEi5ZVgu+g=;
 b=kBomwKf3u1x/GdBsubJyfzkz27u45UzkibOInFzOrNQV9byMCFmQ500sIyY1YqUXZghk7S6uFLBcuueO+uedXsl29KlO7mcoshnl/nwAp3l8Zo89wDUSgfBtnENutITdXoO4rUzAlPDyjlNmXSPZanJX7pa3+owxZJlPay/L0XRrUn+63xAKP14SiEWMf/nzmgnUa57XFc7Tb0d8ONSoPu0O6XyP6wSQFrwUoVRDOJMRQzg3B6tAN65t3QS/JH60dZaPd80shR1zvd/ZvstERbjpyy494UX6n86rrUWKcwWNMEImXXBoRAmBx+KCa7yBi7m/vz9zxnDWl5JzR9OmDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGTIQeg0+eKDbwcVyrM63ya+ly96ipnAwkEi5ZVgu+g=;
 b=d4AOQsMaJ3MTgGO8D94KI2tJywTYv7udlvUKkEmqtQvfAS0eF4GxLMcZ329JFndFfNQajD9NxlJWKjTib/9sKYxAjdtdo/Y+LNBvykFdKkThsaAW0884kBaPqc5MBFxS/5ffbxFJ0PjOkJENw2rz6RMQ/PFc3C0fBANOB86NEZc=
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM (52.133.156.139) by
 HK0P153MB0290.APCP153.PROD.OUTLOOK.COM (52.132.236.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.2; Thu, 13 Feb 2020 04:18:01 +0000
Received: from HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432]) by HK0P153MB0148.APCP153.PROD.OUTLOOK.COM
 ([fe80::58ea:c6ae:4ea3:8432%5]) with mapi id 15.20.2750.007; Thu, 13 Feb 2020
 04:18:01 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Boqun Feng <boqun.feng@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
Subject: RE: [PATCH v3 3/3] PCI: hv: Introduce hv_msi_entry
Thread-Topic: [PATCH v3 3/3] PCI: hv: Introduce hv_msi_entry
Thread-Index: AQHV38PZxjAi0xWAZkW4JMZC1Le8B6gYh+3Q
Date:   Thu, 13 Feb 2020 04:18:01 +0000
Message-ID: <HK0P153MB0148834D630E95D055CE051CBF1A0@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
 <20200210033953.99692-4-boqun.feng@gmail.com>
In-Reply-To: <20200210033953.99692-4-boqun.feng@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-13T04:17:59.5083367Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=638e90be-ea16-4589-af53-af25dfb78032;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:c129:4d3:3571:d407]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 675f161b-6400-41bd-d577-08d7b03bb6ec
x-ms-traffictypediagnostic: HK0P153MB0290:|HK0P153MB0290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB02901B88A669AD74C3ABA5C6BF1A0@HK0P153MB0290.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(110136005)(8676002)(81156014)(81166006)(54906003)(6506007)(8990500004)(478600001)(55016002)(9686003)(10290500003)(2906002)(86362001)(4326008)(7416002)(4744005)(316002)(66446008)(76116006)(5660300002)(66946007)(52536014)(66476007)(8936002)(7696005)(33656002)(66556008)(186003)(71200400001)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:HK0P153MB0290;H:HK0P153MB0148.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6RwGZMCuSSzDhboykzAGybYDG1aQ9PboIHleaIeNXX764UC3bSVKc0M5KNRGl0ZVf5xnNlMd1bi/bgTyFDBUd4xheWmUo4Ws2Y+AVEqMx/Tahb8ty4WvraL9I+bvLM41hXcQZyush7QXsadnegOplHZPounrc9KYW+pZjEfBP61RJk3wtIb0P5eGSgXwXeUWSw0xDt2h/lULfTvTI93Sc2Dno0b1Yqf0QaPSOeDiNVOfgi5MR6Bz5ax15DpntUh6Q8nPhW6Qfv7RLuBbTK894lhj8raas8poAd3HEugd531q3dMW1ddSJx2oSFr82c+snRYWCq4TZcXb8H9aDU4Ge8GgNlvxPqZwvrDh9dEK6WQM9a/mmFU7lvkhOH6ZcoWLULA5NL8c/FlHRbKHJoMia++3JwWfzvvscxvsSsaOa1EV1xzcpiR25RJhfbAaI9qN
x-ms-exchange-antispam-messagedata: tKrFCSzonWEko5Qa9fGTZVqILqFhOHAhJ+SouEREKgQFIp+LAAbCvW+rgp/C5jaRm0jtpaMhG8iIMFyivbz1JMJt/plCAUaDiUlsItFadQniI/48oQzKth8ITKhrX9yWjQQzO0HeYCEZnu3DN06abBu1An7AMGeNwLY5AE9WsK9y+EHXo4fqWPSDeaAU8qCwvUwhTtiwGFjPCmcluH3FCQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 675f161b-6400-41bd-d577-08d7b03bb6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 04:18:01.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bqc4X/R8cZQ1lgKqFfXBJC+Eos/vwDnHCiI8Qg017y2V5bbFjrJask/hYdhvBVTvao4PgUoW0bpEBTVlEIpfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0290
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Boqun Feng
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h
> b/arch/x86/include/asm/hyperv-tlfs.h
>=20
> +union hv_msi_entry {
> +	u64 as_uint64;
> +	struct {
> +		u32 address;
> +		u32 data;
> +	} __packed;
> +};

Just a small thing: should we move the __packed to after the "}" of
the union hv_msi_entry ?

Reviewed-by: Dexuan Cui <decui@microsoft.com>
