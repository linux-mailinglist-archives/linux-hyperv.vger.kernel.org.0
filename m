Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4564410F43B
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Dec 2019 01:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfLCAuD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Dec 2019 19:50:03 -0500
Received: from mail-eopbgr770135.outbound.protection.outlook.com ([40.107.77.135]:43926
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfLCAuD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Dec 2019 19:50:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OG/Ld6C1MF2PZBIla7/375neOUziCUhykUEUMTZo+8L+d2j4nJ+LG22V5Hf0XCd72VELCryPUJxKYrwQQbVRgQmTCK4mX3cvnzEFGigAHYGJSHhBY8jAOinDz/IUbJapRKLgqGlURGexcPcTjn63ZGe4jDvLIs75fG/ivsnjQ4/XTGWEu65G1Umf5/lF3NAowK0UY8ONFTuCAkdmPXnlRT9/JyCQDEIpZdyt056zGH8tVBjySGhkgCuKJL2oiGV7K96BOgx6fpuePSL8NMmH6Jd8lElrzv7UuqN4gIhlwRnnGY4983NccUAjHcEN4dtf+UgIOrCqfF+xlpg3sonfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF4fds46BzQhJPCg9S6bYc8NOr2F5rdwGH5DrTHcmIc=;
 b=UjrlzwERMHJ252ro/ui90DNhpfr+svMhk/PbnS6DiXT1cVwaJokzf2uMZKcd3PfASYl/LMnLD0qdKC+KQwIll+Wbayd+bHKekVi6FlBAq0lCyr0CO67B204zLDPY5nCK4EQLwjtvazlpb0AVk5rjp65NfBdd57r2pGH+RxvCbYy8VjoMrtP9BTCskFl5X6A0LaVmdTkRx73pG7GSflJqPEqXAZ7gsfTC1Te6S4H3im9cSlBeD3YOeem4YeX5PJWSRpgpIgL7+1fD8JlbRXVVdkHcTt646BA0+tI2svIJMOV0hBvLlJTCbas5JGFP1EXT6f/6jYE8lRKvu8BI6sBk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF4fds46BzQhJPCg9S6bYc8NOr2F5rdwGH5DrTHcmIc=;
 b=Jct2II0J7w9zOxDIAGDOY3uppgInJpb8apHkrvtUK+TouICPbOK57iGb7ENJk3FAmMJX66BKFqJIYwyGh+WV7LpFylvGRc22tAlzqakZqtCcP+VX+EV80eYrRUFH/MSoAhMXuqppmZdhue1vmQQOFhnzywWmEB5ogbR04GpW8OI=
Received: from MW2PR2101MB1132.namprd21.prod.outlook.com (52.132.146.17) by
 MW2PR2101MB0938.namprd21.prod.outlook.com (52.132.146.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.2; Tue, 3 Dec 2019 00:49:57 +0000
Received: from MW2PR2101MB1132.namprd21.prod.outlook.com
 ([fe80::5499:4a0f:6079:dcb3]) by MW2PR2101MB1132.namprd21.prod.outlook.com
 ([fe80::5499:4a0f:6079:dcb3%3]) with mapi id 15.20.2538.000; Tue, 3 Dec 2019
 00:49:57 +0000
From:   Long Li <longli@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH 2/2] PCI: hv: Add support for protocol 1.3 and
 support PCI_BUS_RELATIONS2
Thread-Topic: [EXTERNAL] [PATCH 2/2] PCI: hv: Add support for protocol 1.3 and
 support PCI_BUS_RELATIONS2
Thread-Index: AQHVoaFcMccAfvEwC0apfMtqY7fC/6enlbaAgAALSyA=
Date:   Tue, 3 Dec 2019 00:49:57 +0000
Message-ID: <MW2PR2101MB1132621C7DA3BF2EE1AD1E84CE420@MW2PR2101MB1132.namprd21.prod.outlook.com>
References: <1574474229-44840-1-git-send-email-longli@linuxonhyperv.com>
 <1574474229-44840-2-git-send-email-longli@linuxonhyperv.com>
 <PU1P153MB0169CFE46920BAEEE11CA9B7BF430@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169CFE46920BAEEE11CA9B7BF430@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-12-02T23:59:07.6209316Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f258566e-1d09-4e97-950d-9e44dee110b0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:1:eded:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76eca5b9-0093-4507-34e7-08d7778ab819
x-ms-traffictypediagnostic: MW2PR2101MB0938:|MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0938E232C8A097DD30A0E747CE420@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(99286004)(14454004)(10290500003)(7696005)(6506007)(186003)(478600001)(74316002)(86362001)(2906002)(64756008)(81156014)(229853002)(76116006)(316002)(33656002)(256004)(2201001)(52536014)(66446008)(10090500001)(5660300002)(46003)(305945005)(76176011)(81166006)(9686003)(6116002)(25786009)(22452003)(6246003)(8990500004)(66476007)(102836004)(1511001)(66556008)(55016002)(7736002)(8936002)(71190400001)(71200400001)(110136005)(11346002)(446003)(2501003)(66946007)(6436002)(8676002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0938;H:MW2PR2101MB1132.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jO+cK53koXammEVEKW/cHLkGAaibohJCcdznlhKOKq0lTSrq9j1goYbb6wNz2tVR9pdyWytdIJWAoG0G73gC6fvda9RzkSMTbfXXUgSQqdLjmKQ3c2qpo4LxuNrOxofXlRJwTt/UCCAZPcPyyRPvh8lf9c9qOX10k2j2f7uKDqJxAOwnjGqddSdxQvbNu7S7Z//d7ZL9UNmG65Nl2xyVEpgqVt0sErisl4bcEwBk8rLGaQH2sPHQ+pgoXcGUGjqPTUTB1KSTlEJHwCIiqdYL3jcSiIspRpIgPBIEUL2GbDa/th6RUA8V+gV2xfg/WQ9L+pBnWznZmIEYNLpi6A8Pi3rPzBobmFarVVdvT3POEz3Lm0Q2rfCnj/wDDkZD1y61dPuNc0Jw2E/Qrnt37XdwT9QEseSWcRVrotRcLenaF3uS97gCYvgPfn00cYEn7Ift
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eca5b9-0093-4507-34e7-08d7778ab819
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 00:49:57.2187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDJVvKA9e13bm59bJwOrR1CDJu9kTYANrKrxtGbgPJneeIDXKv779HJFr/+BzMkqAU8AiFylna7nKSKkNt32jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: RE: [EXTERNAL] [PATCH 2/2] PCI: hv: Add support for protocol 1.3 =
and
>support PCI_BUS_RELATIONS2
>
>> From: linux-hyperv-owner@vger.kernel.org
>> Sent: Friday, November 22, 2019 5:57 PM  ...
>> @@ -63,6 +63,7 @@
>>  enum pci_protocol_version_t {
>>  	PCI_PROTOCOL_VERSION_1_1 =3D PCI_MAKE_VERSION(1, 1),	/*
>Win10
>> */
>>  	PCI_PROTOCOL_VERSION_1_2 =3D PCI_MAKE_VERSION(1, 2),	/* RS1
>*/
>> +	PCI_PROTOCOL_VERSION_1_3 =3D PCI_MAKE_VERSION(1, 3),	/* VB
>*/
>>  };
>
>What is "VB" ? Can we use a more meaningful name here? :-)

Vibranium.

>
>> +struct pci_function_description2 {
>> +	u16	v_id;	/* vendor ID */
>> +	u16	d_id;	/* device ID */
>> +	u8	rev;
>> +	u8	prog_intf;
>> +	u8	subclass;
>> +	u8	base_class;
>> +	u32	subsystem_id;
>> +	union win_slot_encoding win_slot;
>
>space -> TAB?
>
>> +/*
>> + * Set NUMA node for the devices on the bus  */ static void
>> +pci_assign_numa_node(struct hv_pcibus_device *hbus)
>
>IMO we'd better add a "hv_" prefix to this function's name, otherwise it l=
ooks
>more like a generic PCI subsystem API.

I will send v2 to address comments above.

>
>> +{
>> +	struct pci_dev *dev;
>> +	struct pci_bus *bus =3D hbus->pci_bus;
>> +	struct hv_pci_dev *hv_dev;
>> +
>> +	list_for_each_entry(dev, &bus->devices, bus_list) {
>> +		hv_dev =3D get_pcichild_wslot(hbus, devfn_to_wslot(dev-
>>devfn));
>> +		if (!hv_dev)
>> +			continue;
>> +
>> +		if (hv_dev->desc.flags &
>HV_PCI_DEVICE_FLAG_NUMA_AFFINITY)
>> +			set_dev_node(&dev->dev, hv_dev-
>>desc.virtual_numa_node);
>> +	}
>> +}
>
>Can you please give a brief background introduction to dev->numa_node, e.g=
.
>how is it used here? -- is it used when a PCI device driver (e.g. the mlx
>driver) asks the kernel to allocate memory for DMA, or allocate MSI interr=
upts?
>How big is the performance gain in the tests? I'm curious as it looks uncl=
ear to
>me how dev->numa_node is used by the PCI subsystem.

numa_node can be used by a device driver (if it's numa aware) to setup its =
internal data structures and allocate its MSI.

As an example, you can look at "drivers/net/ethernet/mellanox/mlx4/main.c: =
mlx4_load_one()":
It stores the value at : dev->numa_node =3D dev_to_node(&pdev->dev);
after that, dev->numa_node  is used through driver.

numa_node is also exported though /sys to user-mode, so a NUMA aware applic=
ation (e.g. MPI) can figure out how to pin itself to selected CPUs for the =
best latency.

>
>Thanks,
>-- Dexuan
