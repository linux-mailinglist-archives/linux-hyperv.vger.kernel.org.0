Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67C4193075
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 19:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCYSes (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 14:34:48 -0400
Received: from mail-mw2nam10on2097.outbound.protection.outlook.com ([40.107.94.97]:5697
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727027AbgCYSer (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 14:34:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUSkyjpr651DzQ7qnQqMKGONpf6e+PUIYSSY4d4eCf/cbvF6I17hq/0ZhXzNmDMFM2eXWmprJJVcWNEXktjFoTy7VaGVx+NxpXR6v5T+hJIAboUFz0W2KgC869vxcR6UhyTSIw7MEWc3EpcfOxw+VSbbHVU3Gzr0ncJbI4nE+ceItvafA38jZz5zgABYoAy0O1I0EtmljOEDJFUeDGS/NrAOQcujEXYxaZoXXWfQNZrq+zmPCTjXxzI2vckWbDcX1QiQ6INzcnsdXqK6PlhM84AAhtntJIz3RmoCPIlpN9dBTpTBjj4N1qYO2ljXZ91p05vO5lvHfafmR85+j5eC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgUxVdex1iU7QIEig9HQQ8bFCESH7ip4yo3v0I/OQ6g=;
 b=bFxklnucx+3jGFEHC8bBQOS/H+GpIUkr1lX8ZBKnmXdSxdPYZKQX/XOF40zSwC/hJX2dAwSKfz1c6sh511kwNFguzGBqYlmmYU3gF7UsOtv4WK9UWoxckVAG8zAmUUdPu+/AoDdnvyc7R1Rpy31Rj173zY5IDsm934Qyy46MWiqLqoXgK2OQT/59Tcfi1Pfya0B2uIaW73ikU6WF9Bbw7iIcVf+JGRsGa9LSmq8c0V8ukTaLKyauqHTgWbq04FSnOwIhjp9aOhKFpjdwbi9hV4HoEH9afgCq1tfNkD21urQlo6juKNYX8HUoI/VsYZlLSDnpEmhUxeEbY+k5g4AYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgUxVdex1iU7QIEig9HQQ8bFCESH7ip4yo3v0I/OQ6g=;
 b=L3Njugs09igFuUjMnAF+Jvu//quSw1Mf6LM7w3fICupQJyHRC/UmXTB0ntTfJDt8tx6SS44v1i0LtYXN9u97vDCmGJ9dhahslJrE/L5XKoPGeLFsRP/lkZCWFQbygcKLMzI+v4CJM6FnJeFeM3xM9QvbK1u3FpwhCsjGmb45nOo=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1066.namprd21.prod.outlook.com (2603:10b6:302:a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.2; Wed, 25 Mar
 2020 18:34:45 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.007; Wed, 25 Mar 2020
 18:34:44 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V3 5/6] x86/Hyper-V: Report crash register data when
 sysctl_record_panic_msg is not set
Thread-Topic: [PATCH V3 5/6] x86/Hyper-V: Report crash register data when
 sysctl_record_panic_msg is not set
Thread-Index: AQHWAbHmp7wZEIm1G0eQ3sRDXEuKK6hZpF+w
Date:   Wed, 25 Mar 2020 18:34:44 +0000
Message-ID: <MW2PR2101MB10521B1900ED5A4EF425EF56D7CE0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
 <20200324075720.9462-6-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200324075720.9462-6-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-25T18:34:42.5997724Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c4074bdb-e464-49c7-a17e-80b13c09f274;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7e1bb9e-d57d-4003-8b4e-08d7d0eb30ba
x-ms-traffictypediagnostic: MW2PR2101MB1066:|MW2PR2101MB1066:|MW2PR2101MB1066:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1066B286A37914BF9B1FC350D7CE0@MW2PR2101MB1066.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(33656002)(71200400001)(110136005)(66446008)(6506007)(66556008)(26005)(66946007)(4744005)(186003)(64756008)(66476007)(8990500004)(86362001)(76116006)(54906003)(8676002)(316002)(478600001)(55016002)(5660300002)(10290500003)(6636002)(4326008)(81156014)(9686003)(81166006)(2906002)(8936002)(7696005)(52536014);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9jAdJLTvyxbWRpf0insOBCQTKy5MINI/Gn4O5LpeG/8FseWOUnmRP4UAMjFXvZs4a50FcM42QBWkA64vWPnv3Hqkl6p+rbMekD/piCZzksVSQWfb0aiBxNVEBXleK/wFoTEox85ev8JHDpAmHY1AH6GngPfw4qToFXB13sCL1jkB1KkINuvIsUTmObyPdPddlrzyHVvRZ+OpvtjyNIUHlQgz0ZmOx06LyPR+eLHKDG8lhprmdY7CETvxkzPJNoDHjm5KzyjKQK5O3cb9/LlfJAUMWlJh5lx7DYawJzOdJaMqodGUrYFNVVzViQUJMzfqS0WLE7CKXXj3Fs8leE41h/2RZqrvYpqXDNQruiaK+3myv4y9MqwuJSsyt0VVp2baW6ArIvFohWHSs1CtWMjsVVW9BbN6c4YVAjODZvQ+w2FegdBv8ymqp99RD62IG32w
x-ms-exchange-antispam-messagedata: QX4eaFtkrV8LJr2qg29HOEdz/iY9JIc9wGe95iyfmixtb7RuvQq79BTxpAiQsWlMjc0PTNUW6m9Ei4KU57UYEQ+gxP9KwT3tj2azxuYHtZTmNz61YDX+6tnbmouO2ufiE0WbmkaOHtx2foAOtcOc8g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e1bb9e-d57d-4003-8b4e-08d7d0eb30ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 18:34:44.7269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HR24tqbxaZ9EVP0x5LJfwBHLvdCdVzcq2m/PcM+iw5W/QsMzsoedIBlTZG9cMcZmMeMgZEaM5vndTBfDA4D4JYf+yEQF/o0N7evk9MnCac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1066
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, March 24, 2020 1=
2:57 AM
>=20
> When sysctl_record_panic_msg is not set, the panic will
> not be reported to Hyper-V via hyperv_report_panic_msg().
> So the crash should be reported via hyperv_report_panic().
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
