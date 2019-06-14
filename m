Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31C5C46B58
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2019 22:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfFNU5C (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Jun 2019 16:57:02 -0400
Received: from mail-eopbgr710094.outbound.protection.outlook.com ([40.107.71.94]:6160
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbfFNU5C (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Jun 2019 16:57:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=sjYcMrvmmrQ7/f8D77CR1WuoSf5zLN3wTVX4kwKGuY6m+rcxvuRTBBkC6M1vV0T5ZZSPgHOnrgE+0gYZe9Dl4TfUeRWM/4Z8zYpKtIZ2IcUVXelTXK7sJ0sBwnZkHZjThAaA974V+8R3J4yVGZKND2pZZTWt8wNDVscSqBQ+u5o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmfOtzyYWqnXIj9uQmg//i58SVuDotkk6P5iMP4YSg4=;
 b=GmuKjnbaF0rfZBPJi3KPK47lvO5oQHx57eFWWVlgFK7zql0kslNHP/xMfMeIHO+7TKQoOYewiJKbkJHCdPpwdBL0WVyHZWkbBNYG57nMiL5KgdvCMEOvocPZYKCgnodeSXthTXqmHt6bTgSRalwZO2CmvzVfUvfqtyMACQT8cP8=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmfOtzyYWqnXIj9uQmg//i58SVuDotkk6P5iMP4YSg4=;
 b=LcvpPyUl9xizch5CbXDYSqWh3bXsLo52uYsVmHeFEwEoFVbloAZjT++t4DBMd3HXurRyzVfikZ8JlShFkWgzXQ5tSdqPmzCm1XGXrpWLae1qnweJw9hYMzg3/9z39druPdtV0QSYnzCRA+BkYQ0Pt/l3eOJqiNsHD3O1VmrPiS8=
Received: from BL0PR2101MB1348.namprd21.prod.outlook.com
 (2603:10b6:208:92::22) by BL0PR2101MB1075.namprd21.prod.outlook.com
 (2603:10b6:207:37::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.1; Fri, 14 Jun
 2019 20:56:57 +0000
Received: from BL0PR2101MB1348.namprd21.prod.outlook.com
 ([fe80::ec20:70a:433e:a052]) by BL0PR2101MB1348.namprd21.prod.outlook.com
 ([fe80::ec20:70a:433e:a052%2]) with mapi id 15.20.2008.007; Fri, 14 Jun 2019
 20:56:57 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
CC:     "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH 1/2] hv_balloon: Use a static page for the balloon_up send
 buffer
Thread-Topic: [PATCH 1/2] hv_balloon: Use a static page for the balloon_up
 send buffer
Thread-Index: AQHVIuDkOmV0qWRnFkKsFEp6e9leVqaboWbw
Date:   Fri, 14 Jun 2019 20:56:57 +0000
Message-ID: <BL0PR2101MB13483325CF3D57CBAF578691D7EE0@BL0PR2101MB1348.namprd21.prod.outlook.com>
References: <1560537692-37400-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1560537692-37400-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-06-14T20:56:54.2477622Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0f3f3e3a-4dc5-423f-8203-d240c39c407d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ad6fd25-f9be-456f-d12d-08d6f10ad6aa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB1075;
x-ms-traffictypediagnostic: BL0PR2101MB1075:
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BL0PR2101MB10755403F856763D6DFE4D74D7EE0@BL0PR2101MB1075.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:345;
x-forefront-prvs: 0068C7E410
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(136003)(39860400002)(199004)(189003)(2906002)(6116002)(3846002)(558084003)(186003)(26005)(68736007)(8936002)(10090500001)(1511001)(8676002)(476003)(486006)(446003)(2201001)(52536014)(5660300002)(86362001)(11346002)(256004)(71200400001)(71190400001)(76116006)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(14454004)(6636002)(22452003)(110136005)(74316002)(8990500004)(33656002)(4326008)(99286004)(54906003)(6246003)(55016002)(6436002)(25786009)(102836004)(53936002)(9686003)(316002)(52396003)(478600001)(81166006)(81156014)(66066001)(7736002)(305945005)(229853002)(7696005)(10290500003)(2501003)(6506007)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1075;H:BL0PR2101MB1348.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ktdeuZ9EZWUc4oxfn8tyMbRSwBZ+NHdcV8b/c5ov+wNr1ubsC8bh6zJgbxqV36QTUH/VeWfXe8A1ZYL+4Sb00ctqoExl4IvzWIEIg73mNmp2wEyrPj+6+saWicqH7xqhqrfw9BFuXasv/06g89elUj+FRRyZikpj4PWKCJjUCUcHKwMuHbNFh9txjtDEurNv4wffZdFHEnPRRuHtAIiDLRGGXPco1geR/h0W6ADMfsSKoXFSGhb3YMIaq3Or0S1H5oencDnWr5urhZk7/0TVLRUqc0GIRkOgFvlTz2p0Ig8OjWKgW+pi2uhFLG8LgAfkey/s1S6ZNpQirm9jQE5itj91HJGe/fKEQw+PK1e5MIbphh3iLGc8D2gu2giYpuSEeONxP60kJV9On1NO8P2cJ4ee50cE+JVvR6clJ+FDn/s=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad6fd25-f9be-456f-d12d-08d6f10ad6aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2019 20:56:57.1348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1075
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4gIFNlbnQ6IEZyaWRheSwgSnVu
ZSAxNCwgMjAxOSAxMTo0MiBBTQ0KPiANCj4gSXQncyB1bm5lY2Vzc2FyeSB0byBkeW5hbWljYWxs
eSBhbGxvY2F0ZSB0aGUgYnVmZmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGV4dWFuIEN1aSA8
ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2h2L2h2X2JhbGxvb24uYyB8
IDE5ICsrKystLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDE1IGRlbGV0aW9ucygtKQ0KPiANCg0KUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxt
aWtlbGxleUBtaWNyb3NvZnQuY29tPg0K
