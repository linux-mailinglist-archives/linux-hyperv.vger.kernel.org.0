Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E8736777A
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Apr 2021 04:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhDVCb7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Apr 2021 22:31:59 -0400
Received: from mail-eopbgr760123.outbound.protection.outlook.com ([40.107.76.123]:21134
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230259AbhDVCb7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Apr 2021 22:31:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6x5121hdmyGi/UoWmqD12g1Q4LSV0hgQzEzzvHAINN9p9vQWICWsfrdu9LTIjFVetoMYdD+klnfsi5euEEPWlLnxB1z/qv+SnSuHAMvXXJtcDSK0k1+f8C26R5eO4TRQI5MBx7iVMshsgKZ/frIlQhM2xsBYi8tse+8TYyOcGg8G0/oFPe5sCUzq5tlWxneKlrmPGZeVbHqi6dkHz61kM2Wa17NXm4z6OdAh9i9AHxXpeHJ2NBB/q5qFK2napGhb8Cp4ir2Z/7/xCj3D03JfLmqnfX59hg6dQngg4MqHe6iVhqXqPpw43aksjlDPk2GYLdk2Ge2zaX6q4Lnyt8X+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSmKIosZ1KWHkSkh6/BOsrkDxKXU9buulbMbhyeu6xE=;
 b=Av7LmtInlpM3KEaFO2+thZG+Gbpjt1m5HQayl+W6261Wv14hJbaGobQRNom1c523EIRsuW3H4GSw1epdGfsJ9Xrt+y7ULcQB5HpIMgwQcmqsGr+8vektS7QXgCzi5MSWXuROSIXWRj+6EZjwR8iZuoFqyNSVf79jhUP6SOgI8hgXAplIprx3mIKiY/n8uRpEHIrboswPAL03ZTl1JrdN+oyB33i07A7yv9NnlejI0BvVgvWz72awTFMHZKE7MEq/+8wmy7FjSfDeoqd3aSECKwJt248J8gwzz3+qvmduF212EbLKkcoNut3TE5IT4o5rXuBYZvkXj3lE7wSp018hZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSmKIosZ1KWHkSkh6/BOsrkDxKXU9buulbMbhyeu6xE=;
 b=jrhEOS2jHifTcftIMHNUd2kUDU55bq343GbJ5w5OFjYFkAzX1uMBuhg08QQ2jsysy0FxhLwR7FJywhUzZi8pC6vNGRMSYA2CdN73/wsDCF3gtM3KyMsTkpriuloGXGPqtAVIoHn5ddhogEKCq5VsrHbejuv/x+LNxhRX2xXwTWo=
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 (2603:10b6:302:10::24) by MWHPR21MB0637.namprd21.prod.outlook.com
 (2603:10b6:300:127::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.5; Thu, 22 Apr
 2021 02:31:23 +0000
Received: from MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d]) by MW2PR2101MB0892.namprd21.prod.outlook.com
 ([fe80::5548:cbd8:43cd:aa3d%6]) with mapi id 15.20.4065.008; Thu, 22 Apr 2021
 02:31:23 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
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
Subject: RE: [PATCH] PCI: hv: Fix a race condition when removing the device
Thread-Topic: [PATCH] PCI: hv: Fix a race condition when removing the device
Thread-Index: AQHXNVHtsv1pPhn/lUymN/4kjb1Ps6q/O9jQgAAqeACAABF+EIAAVhsw
Date:   Thu, 22 Apr 2021 02:31:23 +0000
Message-ID: <MW2PR2101MB0892B264810E6E6E54A96C4DBF469@MW2PR2101MB0892.namprd21.prod.outlook.com>
References: <1618860054-928-1-git-send-email-longli@linuxonhyperv.com>
 <MWHPR21MB1593CAEAFB8988ECB93BE6E3D7479@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BYAPR21MB12711AF8B782FAA4B492D0CFCE479@BYAPR21MB1271.namprd21.prod.outlook.com>
 <MWHPR21MB15933F28861A2C448C3F233DD7479@MWHPR21MB1593.namprd21.prod.outlook.com>
In-Reply-To: <MWHPR21MB15933F28861A2C448C3F233DD7479@MWHPR21MB1593.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0c2cd82d-a9ce-4184-9a5b-6c1855cc9093;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-04-21T17:24:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:8b00:6b90:688b:1c6e:a2b1:f6c7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a973216a-8340-4883-71f2-08d90536b8e4
x-ms-traffictypediagnostic: MWHPR21MB0637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0637F25659A253D7362F1214BF469@MWHPR21MB0637.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SlNA6XE8sScjC31HUGDStsH63TJYdxXBixMYb4rZO6ruJsj4HwbiRnVvxPUDsjUvZjS9Ctaqt1XnW57JDdEKciLrwpaoL+r2cQyvpDlvO/sGza4LVWxb1LGruSu50/QsI/5h08p+lpjctYYRgdCMUdgZUTnT1IF7rvAWuXyo0tEAZQ7x9/2yo6AuxdEZ7xii9CLSlJhyJFLCaV1bfLAerJMw9RgI01tpu9bLgkomB0dbgjOdJsiw6jiIpnJWItxQ4VkjbiveGt1vvN3/CxmR1wBCthlElbYr2MOCI2gxi4Hx+FtGK6VavKya/5HK12yj/tmRxt7rPp2KaljDcFptlW9EhRAbY2lLwKC4hvcfbeAOMi++5HDS/A0w/m7OfrJTHU58sRG2z7M17wTc2/a8Af7vcd1nG8WFCjIWVuHgfkA8EsW7flkbiPGMs6QAI5Z8Y8rHfFKipfR2FVkQl7C4kuUtRyuHHApJ2xIjofup3rm/ICfXiwfGcyKq8ziC5slMS8YXTudht9+MyGjkfBMiSkdQXCY4jab0Pp1flZSjvDPe5Ps4/q7+FO5dnzylZJ//T23dTQblFr3YNrGK27pzIdQexgNEzZC/Apuphn+wJ4GwD3o/9XImR5NJWc62s8GpEHsfcPLg9pERRHqSwTnVrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB0892.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(5660300002)(55016002)(9686003)(8990500004)(10290500003)(52536014)(478600001)(2906002)(186003)(8936002)(110136005)(33656002)(8676002)(921005)(122000001)(38100700002)(76116006)(86362001)(7696005)(316002)(64756008)(66476007)(66446008)(66946007)(66556008)(82960400001)(82950400001)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kL8O+n8Xx3LOj2UgUhB8lqREY7s54oubozQWnKNLMbT7gaN808hM3c692c+Z?=
 =?us-ascii?Q?2uqyEDcK93vNMcdsM5mSNk5BZOGVtDJmmzovnOEW+LoBBao3jizZtWoe9/gR?=
 =?us-ascii?Q?hrqq5aGv8shGg1iObUI6RydIabSHzGotjyZk9kAHh/3ZojUX2VmkIvgx9ht8?=
 =?us-ascii?Q?n/1mP2NuCDuwcVk2eExQRoMd0gLz8EBz8j1nUQtWtgB4NhDS5z8bmHSAOubz?=
 =?us-ascii?Q?Fxb1adlz72xi8sd1Fvma+wakm9u9X0Yv6//yGZh0kXPt9LliXJQ1SXqZHaGq?=
 =?us-ascii?Q?uTY20SPDRLnBTi+GYsCwI1jb1dm74gxLBQP8x73XfroSobPG5de8G8pr/5zU?=
 =?us-ascii?Q?IZ+E0v4JWMm+8E2vmcLgwUw8nYMf7Rudd9CLFTv4QT+z+6QJAiDFzfG1Yubk?=
 =?us-ascii?Q?6oWddHgiQE/vGnzh3oIZbkPgDJsVVz67GJzQMfGIajjrBtmcdFfFEbF+j99c?=
 =?us-ascii?Q?B2g9JnCHKNnNs+J18PvJoa3MO5XCaT4J3171HT7OcSJEoaa23D+hkBs8G9As?=
 =?us-ascii?Q?nrHbI20ibDU4xO7aKsVQlgMH/3a0Dzd2HwYUdRQYXNfasp889gm3Zii4Ex1D?=
 =?us-ascii?Q?XBqUBjhKnaJN3tmncwQFT0KGEKQ2zt3DFVxLI35sM3DBcgPU1OK47XBbesmv?=
 =?us-ascii?Q?VyLTUkSXkQbTnY4zMy0OJFBMeAO0zeUpWvyhkM+OEYNgItzzjVk5VV1VMVbp?=
 =?us-ascii?Q?czeflfREuE3SYeQbsDO989ZY2X2sjpz9VaXTkHSXk0NkjYHvhTVMvez0F6iY?=
 =?us-ascii?Q?Js8MivEEJSTWCBg9qhz7Oa185i6mrT4BJCeynwZB81M7NI/eYCAw7LdMyM7b?=
 =?us-ascii?Q?HLDRHFLC740CBVayjO49lidIFM+jbJgWIRkU8iGgqc/RNHU9ljquh+VD5sxO?=
 =?us-ascii?Q?FzFwzpD/QP80fQy8LMCYzX02scWaxICHG0qOaL83os80RX/dIQrw2ITvGHq9?=
 =?us-ascii?Q?d33jVpQ/tWitpz2hW8CKfuwGLGNMoTwN7DzWw2VLHwaJCSK4NI5+hBEqTGMh?=
 =?us-ascii?Q?MDgIDLlrzu0GtchGqaW3mPRH6bInrzFXiiHWyHH6USB3yHICwW3e5qm0+MfS?=
 =?us-ascii?Q?epmSKwGXsrEp1i0GhNdTc2nk+8rlIoSI9i8qOBzoGSIrGcA4GGEcxEJpeQqn?=
 =?us-ascii?Q?TKrmPhWHHhLoMaHAAYOlqNa09OKvPO7M6yvFT0ec/v/woXgMmqkRYGOsWw7p?=
 =?us-ascii?Q?sBNuWsZV2j4Zyw7QMBSCww/eptBsbGIP9UPgGBsHengah8cgNFwQxW8PDbod?=
 =?us-ascii?Q?YesLhLVep5sednO+rpKMFG2t48P/tX6VKuOfbdWDZd4m/hjidFvXlSG70mu7?=
 =?us-ascii?Q?tKPodlDaD551tqNJNpPzik1YMXCB/eO1mgjh4FvgorF0Rkf5HV2yVCFeZzMU?=
 =?us-ascii?Q?oPXbxJ+V6Go2Nx6nZSfJduq8N6ks?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB0892.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a973216a-8340-4883-71f2-08d90536b8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 02:31:23.5968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wCuUjb1hi7mh1KOasvGCWUfnW0tGnCeM05Tm3a+TEQmRgneNwkrjd+CWGn8EwsdxAqctmKfGmci3MMS5YW6tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0637
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Wednesday, April 21, 2021 2:06 PM
>  ...
> > Yes I think put_hvpcibus() and get_hvpcibus() can be removed, as we hav=
e
> > changed to use
> > a dedicated workqueue for hbus since they were introduced.
> >
> > But we still need to call tasklet_disable/enable() the same way
> > hv_pci_suspend() does, the
> > reason is that we need to protect hbus->state. This value needs to be
> consistent for the
> > driver. For example, a CPU may decide to schedule a work on a work queu=
e
> that we just
> > flushed or destroyed, by reading the wrong hbus->state.
> >
>=20
> Yes, I would agree the tasklet disable/enable are needed, especially sinc=
e
> tasklet_disable()
> is what ensures that the tasklet is not currently running.
>=20
> If the hbus ref counting isn't needed any longer, I would strongly recomm=
end
> adding
> a patch to the series that removes it.  This synchronization stuff is har=
d
> enough to
> understand and reason about; having a leftover mechanism that doesn't rea=
lly
> do
> anything useful makes it nearly impossible. :-)
>=20
> Dexuan -- I'm hoping you can take a look as well and see if you agree.
>=20
> Michael

I also think we can remove the reference counting.

But it looks like there is still race in hv_pci_remove() even with Long's
patch: in hv_pci_remove(), we disable the tasklet, change hbus->state to
hv_pcibus_removing, re-enable the tasklet and flush hbus->wq, and set
hbus->state to hv_pcibus_removed -- what if the channel callback runs
again? -- now hbus->state is no longer hv_pcibus_removing, so
hv_pci_devices_present() -> hv_pci_start_relations_work() and
hv_pci_eject_device() can still add new work items to hbus->wq, and the new
work items may race with the vmbus_close().

It looks like we should remove the state hv_pcibus_removed?

Thanks,
-- Dexuan

