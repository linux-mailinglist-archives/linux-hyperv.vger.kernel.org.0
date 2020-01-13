Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52072139A32
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jan 2020 20:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMTag (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Jan 2020 14:30:36 -0500
Received: from mail-eopbgr760098.outbound.protection.outlook.com ([40.107.76.98]:23156
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgAMTag (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Jan 2020 14:30:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFJWhhKAj4FaegYk3tcaAI7POLSqwyQCV6pY8Hv4mun10im9SAjMlkdi/Pz51DIjTmZ7eFIM7/quNZs95liLQlZjRrEnZZIPPyHPQQUJHuLdxT/CSNgdBUmFQbQ73evrnINpt+sudeeGEKQX6BFt32tHRWm+nvi+ZI/uWMZ7FK03x1dkKdpTQqdlC/2KV++d19UF8Vzm70b9WpAG8+Rhfmv4nTF3EL7fNZjiLdNlofau5JZBpSiGoTIvgJWC8k8PyVdEAEGXqysQmx15ReWxeLKN+NOoVsy23/UDSVEhlJBXVFBgwiDf1NT/UCu+laRaoXsBd4eez21yb8I8glnrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSB5ZxMBQMtYpxQNGiXy4d/0mhJpMuhHxCmJstq1Xzc=;
 b=LFQcGi2WjU1q3PHxNfi/cWw0zvOhg0oEkmC/YC9AKFuol+dU+FoQgkNPtU/mE3i1XwmS25EeVWfAEE95kFKmDymCrdd/7b7DBKAeOyY3ylZwVyJKONJb6fnO0j0C3uIdm1rS7yaFP6529V3T4Z84sgo50gBTdhsM9Hfb9QwGLYCyfJFg35CmYzMexejj0XcBkDNbswdUiBbPG1ywxhGu/zy4m0AD5AaGReg8FNhOP8qQI1NGqF0E7H18nJwflJoS/bKh4BIWDFE07e+6WDhNCBYZuTP3IRltq6ZszDWs3Vd3kJFnmAVG1QiSNnQaboufbOLeJSo+w0XsN+7xecG3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSB5ZxMBQMtYpxQNGiXy4d/0mhJpMuhHxCmJstq1Xzc=;
 b=fNayqSGTi1mxyfAw3Sm4GTywOdPTSCH2aDXCXsLu7Iyn0TaE9GNbkZP7ui0aGL/7+bV8ET64WERTNQY7Ui9PsJZm42ujMd2n2VmelWDs4ByRNuxMzA/LTdK75cRL1AehoXDS6xFakp0dHwFXGna3OZoWawD+FNdxY8w3fSzEMUw=
Received: from BL0PR2101MB1123.namprd21.prod.outlook.com (52.132.20.151) by
 BL0PR2101MB0996.namprd21.prod.outlook.com (52.132.23.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.6; Mon, 13 Jan 2020 19:30:33 +0000
Received: from BL0PR2101MB1123.namprd21.prod.outlook.com
 ([fe80::d1de:7b03:3f66:19fb]) by BL0PR2101MB1123.namprd21.prod.outlook.com
 ([fe80::d1de:7b03:3f66:19fb%6]) with mapi id 15.20.2644.015; Mon, 13 Jan 2020
 19:30:33 +0000
From:   Long Li <longli@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v3 1/2] PCI: hv: Decouple the func definition in
 hv_dr_state from VSP message
Thread-Topic: [Patch v3 1/2] PCI: hv: Decouple the func definition in
 hv_dr_state from VSP message
Thread-Index: AQHVvCRkF/InBl2gY02lH0V30pa41qflORQggACewYCAAz9xEA==
Date:   Mon, 13 Jan 2020 19:30:33 +0000
Message-ID: <BL0PR2101MB1123E4716CFCB1990968D4FACE350@BL0PR2101MB1123.namprd21.prod.outlook.com>
References: <BL0PR2101MB1123229A668A200C34A2888ECE3B0@BL0PR2101MB1123.namprd21.prod.outlook.com>
 <20200111175341.GA238104@google.com>
In-Reply-To: <20200111175341.GA238104@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a279fdf0-03b7-4921-8d88-000080fcd1fe;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-13T19:29:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:edec:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00d59c32-ba87-4e9a-1992-08d7985f0eef
x-ms-traffictypediagnostic: BL0PR2101MB0996:|BL0PR2101MB0996:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR2101MB09962DBFDF2DF63388B327CECE350@BL0PR2101MB0996.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(199004)(189003)(478600001)(66946007)(66476007)(66556008)(54906003)(66446008)(76116006)(6506007)(7696005)(15650500001)(6916009)(33656002)(10290500003)(64756008)(8936002)(5660300002)(186003)(52536014)(316002)(8990500004)(4326008)(8676002)(86362001)(81156014)(81166006)(2906002)(55016002)(9686003)(71200400001)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0996;H:BL0PR2101MB1123.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MiYDH5EhqGyHtgAhTe7t3dUcC/n3oMOrPYbFkigl+44BbEceK2j4UXfuaLwnMPivdnUkgR12FimNQDX3tY4fymeKFwR1W8b7DsCFeygfMPCd+apebySndwX86bacoXT1lylyj+yddEc55oh16VQCbwZ5hJQ896MEjGid8URHpTqcdCjoATeUwhu3Q5DdKL+CkyvQrnzqLXf9Rbl9YfI+2uWarPBLu+e5WInkmeCSp/VywOAXHcqjwNgZVwSCRyrG8OQN+Ppz2NCdSzWxnyhWIX9iQreM5ZdWj+Q8D7LHef5UasQFcPxL/pZJwvXA11MNKdiC/72U7Y5wVyFRfHLZoxDBnXM8tVLULkULFh6jXnEZ/+O/2GK8FnMF+5cE17QYVY9YTgx7rCISSdM2h8ERs3T6LNtvnWVzZw++r1Pt+oMd7mCJDlu9IMdKY8cquSsP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d59c32-ba87-4e9a-1992-08d7985f0eef
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 19:30:33.5070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6qQqugHrpX7qHJki3v2FlRJyRj9Qo1HdJjyOROaNxGzC4oMzlK6MTru9FpWhHHtit/UWHOaHNQY9YZTfX0g+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0996
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: Re: [Patch v3 1/2] PCI: hv: Decouple the func definition in hv_dr=
_state
>from VSP message
>
>On Sat, Jan 11, 2020 at 08:27:25AM +0000, Long Li wrote:
>> Hi Bjorn,
>>
>> I have addressed all the prior comments in this v3 patch. Please take a =
look.
>
>Lorenzo normally merges hv updates, so I'm sure this is on his list to tak=
e a look.
>I pointed out a few spelling and similar nits, but I didn't review the act=
ual
>substance of v3.
>
>Bjorn

Thanks, I will address your comments and send v4.

Long
