Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4EC8193061
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 19:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCYSaM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 14:30:12 -0400
Received: from mail-bn7nam10on2131.outbound.protection.outlook.com ([40.107.92.131]:34401
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727027AbgCYSaL (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 14:30:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIwc6gJE5J4Pt/xBbAlXtlsPWq/WWxugPAzsByqXmfC935gp2DsAF8KCMX5lv8sDZU3Ng6jP2LA8EMsqSH6qhBqsgv5FuluDmZClJTP7o0Ls8L2kDmHGkBYe6T9v9PHdAXMHWOeLP5ved1/7X6beE2d7rXaNX63HK2NXaACYIN+oQb1sRVh9XXeqec3TKWRYNxrKXN7Aasb/AFTj8xbcKWKmdY6QnQXxEoFcFmTHLYwnptm8mJEHyk0k8ygh0CE0/fVCFoN3apc7RyWp7K4WJ//6qOYCx/cOLM1dw2qyrjg2YmOps2Vp0aUkknmfRJguDxD0ZS8Vkyx9xEZ1d6TvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJLHigURkuRfgwUJajZqmVZY0mG3GPcQa8qTsnLDFHY=;
 b=Gtz2sOc/X3Xil4cUl/IcTTa75c9AFotk0Ss+jwROcyp81MEvc+sWOMJmGYSHrUjRxcemFjAptHSTMN2zXGADceckHbRFdrIyxLisB0sFImE4sZTqIZCKZpODWwfcznMZMsdbNmUswFi1XPvz4UyE6dtf731X9rFh2bBhjO0YW1M2OP5gSFIqc7W/WQPT4AkgSME8D6dlhwTIEMb0FMCyeFBQnjBcxXfPpxweDU9xdFFOZw0yQT82lzUj9GUETzPxCHtfSRjMZDw7hPY87NhLpDhxDLT4VUygjpWEWMJNn5oheWwPTSwHxwFIxD4+Cl5HBoz3MSwaPJBZgHQgYlyx7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJLHigURkuRfgwUJajZqmVZY0mG3GPcQa8qTsnLDFHY=;
 b=Y7QbCmV10ab3d1CFpK1W5IZhVtyVuuF5sITAEnegg0MLRj3c1VPRuDb7z9m9ROYPobhsnvffg+hFDF6/Yf7YDPBC5BF51lPZqecteAeuV2mzf2Ti6Dmxw7igsBquScekeGDl2RnN27n6pXZwrtdUI9fu6Zf05j7y6AiN46ypygs=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.2; Wed, 25 Mar
 2020 18:30:03 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.007; Wed, 25 Mar 2020
 18:30:03 +0000
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
Subject: RE: [PATCH V3 2/6] x86/Hyper-V: Free hv_panic_page when fail to
 register kmsg dump
Thread-Topic: [PATCH V3 2/6] x86/Hyper-V: Free hv_panic_page when fail to
 register kmsg dump
Thread-Index: AQHWAbHhbluCcqaaq0eRaVhLKSlxeKhZoxQg
Date:   Wed, 25 Mar 2020 18:30:03 +0000
Message-ID: <MW2PR2101MB105203D3A3C76D5E93664794D7CE0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
 <20200324075720.9462-3-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200324075720.9462-3-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-25T18:30:01.4294170Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4309bb33-f38b-4703-8a1a-a6baa210580b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f624c053-8a3e-4092-6e3c-08d7d0ea88e3
x-ms-traffictypediagnostic: MW2PR2101MB0938:|MW2PR2101MB0938:|MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0938C7C6063EDD91D2FFF086D7CE0@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:156;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(110136005)(66446008)(64756008)(6506007)(8676002)(66946007)(66556008)(66476007)(2906002)(54906003)(478600001)(33656002)(81156014)(81166006)(26005)(4744005)(8990500004)(10290500003)(186003)(55016002)(71200400001)(7696005)(76116006)(8936002)(5660300002)(86362001)(316002)(4326008)(52536014)(9686003)(921003)(1121003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yvlxRZj1Sk8mgOA2kyBejGkwrDkGkV2W8TAiqKxGf6wf96LyQD4bqMU4AnLsUcud7P9tyFMswxx/3RfsF9ZuqAzsmiz0BrJBukSbQHxhbfCglE788PFOhBHH2RnCf7lN+1jubkcnfkZuz/nOsWXo4e1AMQ+7V0z2fs3r1DRVvcJOcs+aVVPGUg7xGkRl1iExizI3dIgM5eWGtFzcZowv8YaUU2oTFEvt5q6GpP9Sxaeb8RKuIMVI6lFWY24kmxOhYOS2f1JE3br1hUwOtmR+fMYtkC1lgQO5tFMWZQ9K/vaBOfdLo+mM7P89JI4skthIjX8C0XOH5LsyOx7MLggnnETaIBDdg0S0Lb+KUQYxjWdK7CONOROPF4Sw0DzkelZ1R0y9I1/JWkpJR6+9w7+0dD1VFGTMyTsxNvZKNT7ZgKUANH0RlqnwwTh2Tl9vMd/eZdd6Ht3XIZAO3Z7/VOZMsKsPE5ZXSXudgjdZPq/289crycQXb9FK3+egOJa+Hswk
x-ms-exchange-antispam-messagedata: ClWpcAaykQp4V5ESHh5+7qZOVN/kVJrM6Yh9Rp4uiSz9AUK6TghST4GeoWEyVRtn4qArPFU44sE3AvHh/shQwCuOe5H6oPOAzikAaU9DeHPlclmvfzSzkD1VJGg6I2AXCPpcyWY8QmtKaAx7DmzP3A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f624c053-8a3e-4092-6e3c-08d7d0ea88e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 18:30:03.2696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ax5yQmFpomIRx31PJva/kRVhu7v9WBGfWqZg5ix/y93u9AbgvWDfMDLoUdJwZWdtI9BiLYlAjo6bSpoxZQ2FLhsT59+0ExRF/VyEScT8lAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, March 24, 2020 1=
2:57 AM
>
> If kmsg_dump_register() fails, hv_panic_page will not be used
> anywhere.  So free and reset it.
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
> 	- Update commit log
> 	- Remove hv_free_hyperv_page() in the error path
> ---
>  drivers/hv/vmbus_drv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
