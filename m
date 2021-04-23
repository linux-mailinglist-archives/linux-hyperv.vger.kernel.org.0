Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6BE3699DB
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Apr 2021 20:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhDWSkv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Apr 2021 14:40:51 -0400
Received: from mail-mw2nam12on2138.outbound.protection.outlook.com ([40.107.244.138]:49120
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229549AbhDWSku (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Apr 2021 14:40:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhIlskeiV4G+IuJE04JtZ/4H/dU9HbMnj6g3nQnnOBXi7aJLpNilDK8ZTqm0Up8V9YShp9Sx/MlWT4YNM0YNTtymwVuxYXdXHG1Rc6ccQDBqp3JijhLClwyKnnu/nqWn1IodmHUlbg8bthoSHVWs/zyn57KymzKKWLnCIFgrTUYem+A3Ra2zTKM2EtYr9kldJxmT/3jQWzA5OG9G7xB/c06qTWq/OEGlET7Or90JOn/KDVnYJT2oWFzlUw7MCC/X3Y7PHsRQfbpfJFyWrbX7x5uN7DxnCAJ7JEgFp7GdGBdQ+7sVtxOF1dDrlFNREpj2e3gXAc6jAjbsWLVkDZGAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpbL9vLrzcQIwzm5dFgz6iQ5tA+cWzPllKhnRx+kVXY=;
 b=Cjk0z/0x3OrnwwsuzWaWk+LGjqCwJMF7c+L5McjP51Ryyh0CmpQ+MO6dj4y2oLx7LfTJfrB3CTKIowSCo/iBQV5/QkYyzx7Yke7x3arwv7MgVOjLVJSOQjsggw/uD6BvTlmZyk77myQiOiq/RQ9p4WEOCK0sMx6zWE5KA/UzoPg2ZJseOWqzqq7+hpO6W7IhWZJRD9rkTahjaR6P+WMs+Ni03qAmO6sN238pCk4+fTwpFOUrLlfrRmQZwuQlgyKVbwGo67hcs7DV7jgD1Gx0eOlCKmARv4u5KCYA6fuQbqpoFoQdqnK2F3t4NkpvZjKp9BFSNBOyh0Qn55iX0aEWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpbL9vLrzcQIwzm5dFgz6iQ5tA+cWzPllKhnRx+kVXY=;
 b=DwcY/HBIZxAb+oKdRgskvlDLQTTpt6c1jTcRvJ/mz3yyjBrRe9nXtftAfnHR0GNANyIPG627I7JmHrgjQAfKjw6lj1YpYlr7qR9WxBJhSFlVCYJS+QOCnfxdXrM+37bvxjXd97m7LM7ZjQs2BAf5A67l9d03mlv12iNXAnbPzfI=
Received: from BYAPR21MB1271.namprd21.prod.outlook.com (2603:10b6:a03:109::27)
 by BY5PR21MB1507.namprd21.prod.outlook.com (2603:10b6:a03:231::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.7; Fri, 23 Apr
 2021 18:40:12 +0000
Received: from BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86]) by BYAPR21MB1271.namprd21.prod.outlook.com
 ([fe80::c074:b476:d8d6:4e86%9]) with mapi id 15.20.4087.021; Fri, 23 Apr 2021
 18:40:12 +0000
From:   Long Li <longli@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v2 2/2] PCI: hv: Remove unused refcount and supporting
 functions for handling bus device removal
Thread-Topic: [Patch v2 2/2] PCI: hv: Remove unused refcount and supporting
 functions for handling bus device removal
Thread-Index: AQHXNzrM+OyMyEMRRUyvNwFTh5HICqrBszkAgAC9Z0A=
Date:   Fri, 23 Apr 2021 18:40:12 +0000
Message-ID: <BYAPR21MB12711CF66BB8A61FA4A46F05CE459@BYAPR21MB1271.namprd21.prod.outlook.com>
References: <1619070346-21557-1-git-send-email-longli@linuxonhyperv.com>
 <1619070346-21557-2-git-send-email-longli@linuxonhyperv.com>
 <MW2PR2101MB0892BE19CBB08214B7FEA5E9BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB0892BE19CBB08214B7FEA5E9BF459@MW2PR2101MB0892.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=770ed1e0-2138-4406-a319-8c807a78d1fc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-23T07:14:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [76.22.9.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 356a7b9d-c980-461b-3ea6-08d906873a8b
x-ms-traffictypediagnostic: BY5PR21MB1507:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR21MB15070A9046A2ECC997C1721DCE459@BY5PR21MB1507.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0nebs30lpojQpGfpVh/lS/wC89vjl7njbFXvEXVT/y1IwDHh40lb2NmK1TdPNvf330SNVX0ifvFTuTJBgrKEHCPDIeH3bNxs6jEFg4LWqmArJbmUyShUJH7HiU2Bfco1wxWDDvtwozBki+nXPEnR8jm6/UIQVVVYOtJ5IAkyK5a5PZecuuJ+CpLC6toqRCRke45ecCgECnerjZBIy+gJEdud9AAsD3PQTkoa7DADSqu16+/M6BgTPP22ZTQaIn80io7iRtyDg2iQqKWnybLAC+QbR8edcZfC/WVY0DauWqw3l0/gZ0sOPP+Ns39j5Ihh1Gs4ZyKeug2Lzmzfy5vNNDz2Vty46/ESxzNE1A6qcfBD5k5hVnYjWDtXNWdbqjOfnMIfVqSHHK/5NX4mE//GlzSQBkyWIxw0b8RuEWYICqSTwSx4fOG1M3Nk5+O/8MGJJ0ijIvkJpTpZR5tH2UpovfDJLn6/MuOMP0HrF6voSWfVRNEBcfEH0AFFK7nuNHrTPqN3cmHNH7Ls8OsIXRmyLi+C2cY+jU1swzDaWZjvs2tCce4VkMG8nPGQkcYLm4ad9zGiUi7lyE/xZPsOzVekqQIQ/GA26zKslVJOk7bY684VyCHYNVePja7FE0nhmgbV+M4NEi+MU2uX2X4Fcb5q8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1271.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66446008)(64756008)(66946007)(66556008)(66476007)(5660300002)(52536014)(110136005)(316002)(10290500003)(6506007)(478600001)(82960400001)(83380400001)(71200400001)(7696005)(8936002)(82950400001)(86362001)(8676002)(122000001)(26005)(2906002)(8990500004)(55016002)(38100700002)(4744005)(921005)(186003)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GYh4AnmE9HbtpFHEXWmPhUlm4jkSaJZiK+yx90D5lnPMeC5tgRxEd0vvwZfr?=
 =?us-ascii?Q?J3hBxSwidG2/YCfJCBW5r4RMhpLDSF1kkyCSHfzTUKXjYy0l3qoZkFeQ+2gl?=
 =?us-ascii?Q?FzrT14ggKx8UANndTKkjzOwZFoTPZ4Cru0UtGiWgF3O7ebHGPr4aoBEZCSHg?=
 =?us-ascii?Q?sPVgWRqkJsW4f3RDl+7wY2j9AOEFN1ifngMJgocNH1YZKu4Lwd+HGkwjsPv7?=
 =?us-ascii?Q?Ys3msrWYcBqetxh03qWGXJ1mXa/FMlk3/EPfd3oo4MlZyYrUJuEr3UBIa3ZM?=
 =?us-ascii?Q?fCxBTCixXFq+ndtmz3LDQb9u/vWB6+1wYv5E7pPs1qTP0wYjrFXbQjjRRKOC?=
 =?us-ascii?Q?ywJUrI1SU3DLI9P8Uix/yEMu+h4sfoy5326u0tcyU1SZusvt2Z6Z/uPjQ2oy?=
 =?us-ascii?Q?0HkCaOgKBlAzRX344ssuX9plw7vQskG9E2lylMg9Sg0JsUf7TWjcLV5damRX?=
 =?us-ascii?Q?LuglWW7oUC8txgXQOmQsoN9R+isbh0f5XnQyx0EA68vaOf0qx3rnZxsh5cF2?=
 =?us-ascii?Q?ROdyxFI9gOjzwP69QKBUi0m4GzguXUUvNfKI6X4Gx1KZzYLvEWcabgG4RDu3?=
 =?us-ascii?Q?2MxOsnlK7RWiPDDXqAf9wgZekcLpvYcRDu08h6sJibZOt67RMqco5iil6O+m?=
 =?us-ascii?Q?UUsHlc2SF2LN/GNcaF552akTWe6+Cb6nWtehT5oyKYceSu69TTtX/2z+xej8?=
 =?us-ascii?Q?DQXufYrfHKLDkbjg+FV41oDVIlQTYUUh08L7z22b2zg1ePEU6QGRhNPcM58x?=
 =?us-ascii?Q?Loc+8rLl0h7qb1Gi/W2Gm7BGPdI7b6nF2yXAEAla6kDga6fnubKW6emt1PZB?=
 =?us-ascii?Q?eN+ZlFdOdQvgqpOvfefxrUWMvEl4v78SI6bi4kDLmRCvZzdUnDiBbyG+Cb+1?=
 =?us-ascii?Q?tpEr5XVmIrc9VSAFw4cEamnlWS1aMj3vW5CGdXnnmDhRUxdOvquHldTfxTZl?=
 =?us-ascii?Q?sB8+YI9QCkwqCZrvZo/8GVjhDH7PDtAyANeOJMDcAhjYSp7KVmHJDA4w9tHl?=
 =?us-ascii?Q?+Ysrhb5uz1wh1r3sSx0Q9nPbvToPDB5h6G0wyRVKHIysZbX6q4GoP506D17o?=
 =?us-ascii?Q?aoNXba/s+XJHMvCjeNf+GTRBDSeDPGR8ZGe8Po2t+7zap1ShgWJpyDI4GSAz?=
 =?us-ascii?Q?0+wNOzSWCI7AkkD8tZzZb6XSwYgHVSQP+/HvtwUq9/XsSskHWifgnhvU5MaM?=
 =?us-ascii?Q?mTiBo9whTSCHsAa/d3bHqU+ZSIvPds5v6qvcHsPiNAbJMOdbbvLLMNlOfuuj?=
 =?us-ascii?Q?QcrMoKPwIyiMSmGikQO90YcoCqbBAFCJwjQADu8w6vK0UFfo8bG5xqOV2vhq?=
 =?us-ascii?Q?t5Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1271.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356a7b9d-c980-461b-3ea6-08d906873a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:40:12.1741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sLXhdGd0qN4dzC4M1DEOKWEs+4EUyuQi/qA99NThmtZhg5I8I2ldNEDc243O0MrtFnHiNC+H02Zktdvyv+7A8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1507
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: RE: [Patch v2 2/2] PCI: hv: Remove unused refcount and supportin=
g
> functions for handling bus device removal
>=20
> > From: longli@linuxonhyperv.com <longli@linuxonhyperv.com>
> > Sent: Wednesday, April 21, 2021 10:46 PM
> >
> > With the new method of flushing/stopping the workqueue before doing
> > bus removal, the old mechanisum of using refcount and wait for
> > completion
>=20
> mechanisum -> mechanism
>=20
> > is no longer needed. Remove those dead code.
> >
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
>=20
> The patch looks good to me. BTW, can we also remove get_pcichild() and
> put_pcichild() in an extra patch? I suspect we don't really need those ei=
ther.

Those two functions are for protecting accessing to the devices on the hbus=
. There are interactions from PCI layer that need guarantee from hbus that =
the device is present at the time of access.

Why do you think we don't' need those?
