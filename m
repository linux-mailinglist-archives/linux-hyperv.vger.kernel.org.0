Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4410F21D
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Dec 2019 22:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfLBVXM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Dec 2019 16:23:12 -0500
Received: from mail-eopbgr730136.outbound.protection.outlook.com ([40.107.73.136]:5792
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfLBVXM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Dec 2019 16:23:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVx0uJFL7XKdU/zvqsGW+8kVs1hl0ycIhDCDr8JArXXykIVhNma2i/GGUi4800VWHmSgQN5hOQBnHRGV28qdsjhY2N/z4l3ARzbfX3Q5cvTZcShvp8VDqPp/TVZCDqVzo3VKjp1uaDSrGQa3RwZpCWINVeBxulVjQle4qHEh/4ICYDFMkqcwRgiaZrTgzU1eOsUd0JesOnDBAk2seeexYWhrOuyfbpaRbAltM9k/DTouZOBX6QIb/FHqGL73S03M4eFcVcYaGcZXy4PsxBYAxb0wGa7JZXtsoAT9Y9VzYy3eOI+g65gagQZThwWj/WL930P+DJWpyyqmNUGKg6K7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUPwRfmqQsRAMI7qIqr2YmhuR3ZzoCSIeaC3EM1mdy8=;
 b=b8vIFd4nDoVnaVcQx2WEqHlmIBOZz7ZyW4YqPpV7+PgaSn9ZvrCGqFT8OuYaJoPto/zhzV4mWEZc+wVdZQeT0KZ2bg/EMG8ZgHtUOSaQsCTGJ8rx60yVem6c6rYG3tTMYe7WKoNLG+JrDfK6sDSAa/zZsBdpXxxi9ZNmx5MnTep8nW+73u7sfBR6E21NPInpagFWiAT628HE/3rAeKpGOC7Zci5Xfjmck3P6UkRLEQ94j7HSwIFgo9P9Tk2NTk19kZ0UWjEhq5J7zJoArE7C8WGP6zAdhq1Uk/94TZ43OyYHTUcXG1WMSloz/x0ES1JFxfj5eBD5TOBtEUhscXNmPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUPwRfmqQsRAMI7qIqr2YmhuR3ZzoCSIeaC3EM1mdy8=;
 b=hBhKMoxlq+0ggNup9z4S1gw69dnsrdPRXnsAjT5CRXT+arzZ15IFPuzaWC+dqwAOFPbrAlUUSbIybYus1fYixvFvK/qkTj2fPYCNOqCyFB7s+JnIsAf0yTLaBuQ7bRVlpTlN0mMz7Lb/THtqav+BfqEkmjtkZN5ZTR3HbPoZwHA=
Received: from SN6PR2101MB1134.namprd21.prod.outlook.com (52.132.114.23) by
 SN6PR2101MB0976.namprd21.prod.outlook.com (52.132.114.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.1; Mon, 2 Dec 2019 21:23:09 +0000
Received: from SN6PR2101MB1134.namprd21.prod.outlook.com
 ([fe80::5154:fa80:5f3:ad17]) by SN6PR2101MB1134.namprd21.prod.outlook.com
 ([fe80::5154:fa80:5f3:ad17%9]) with mapi id 15.20.2538.000; Mon, 2 Dec 2019
 21:23:09 +0000
From:   Long Li <longli@microsoft.com>
To:     Michael Kelley <mikelley@microsoft.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [EXTERNAL] [PATCH 2/2] PCI: hv: Add support for protocol 1.3 and
 support PCI_BUS_RELATIONS2
Thread-Topic: [EXTERNAL] [PATCH 2/2] PCI: hv: Add support for protocol 1.3 and
 support PCI_BUS_RELATIONS2
Thread-Index: AQHVoaFcMccAfvEwC0apfMtqY7fC/6ejLsAAgAQt+qA=
Date:   Mon, 2 Dec 2019 21:23:09 +0000
Message-ID: <SN6PR2101MB113402749BE289B8B97D9D72CE430@SN6PR2101MB1134.namprd21.prod.outlook.com>
References: <1574474229-44840-1-git-send-email-longli@linuxonhyperv.com>
 <1574474229-44840-2-git-send-email-longli@linuxonhyperv.com>
 <CY4PR21MB0629300E161C5119D4714A64D7410@CY4PR21MB0629.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB0629300E161C5119D4714A64D7410@CY4PR21MB0629.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-30T04:45:34.1746665Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0f1b8475-7cee-41ba-9596-da3f0b1969db;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:9:ede5:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e0889d8-76bb-4f4e-cbd0-08d7776dd491
x-ms-traffictypediagnostic: SN6PR2101MB0976:|SN6PR2101MB0976:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR2101MB097698C66D0C2A59BDA9BDDCCE430@SN6PR2101MB0976.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(136003)(396003)(376002)(189003)(199004)(11346002)(446003)(46003)(6506007)(1511001)(2906002)(8676002)(102836004)(186003)(6116002)(81156014)(256004)(229853002)(81166006)(9686003)(6436002)(14454004)(33656002)(8936002)(76176011)(10290500003)(478600001)(66476007)(25786009)(71190400001)(71200400001)(66946007)(64756008)(66446008)(76116006)(66556008)(2501003)(10090500001)(2201001)(86362001)(8990500004)(6636002)(55016002)(7696005)(99286004)(6246003)(22452003)(316002)(110136005)(74316002)(305945005)(7736002)(52536014)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0976;H:SN6PR2101MB1134.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QElNTHoG3U72m8aBho4Jqs77QS4Y/FmMsdG1Y3PfVYzA54bwN7/3Vrkbqm9IAnZC5PREUD5i/Nve6ojBguK1mDYkvnGCfqxm2+G4Zxx/uQFnRSBl+xKAaBe3iYUscb85pMpQzp/Hd/aymUjFcRUjYSDxIaCvICm6DYiCbiPRDt2iWbJv8klS9nrMO+A93X4RYTcfnd5rFyM1rzfvRBGMVnmLyzND1rL9IyPgg6HGnjIloSO60uLICulFUHpkZrn5OGIneDgKPGLAVDl9Ywozo3TQNpRz3DErO+flrtRMd/BNZXO2qDGR9lojPmWFQASkQUx9x/OjEGhAUvMxPuk4EiiLuNN6jvVmi+kmfKSt6c65kC9cWVTWjT/7yT8CsUQCfOYcAis2MDQ2ajKnwRENAbZubEMKKyrcNMSySkTZKUpOioOnKdtt44KLzHnQskuc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0889d8-76bb-4f4e-cbd0-08d7776dd491
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 21:23:09.5670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ywuVWFPMyK1/jxBW8naaTTp4VwHgX+y1m4g7ca3W5NvWWWCRlkfDR0guxJIyv0XIEJO1g/a0jvzKLxEIBfa3fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0976
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: RE: [EXTERNAL] [PATCH 2/2] PCI: hv: Add support for protocol 1.3 =
and
>support PCI_BUS_RELATIONS2
>
>From: longli@linuxonhyperv.com Sent: Friday, November 22, 2019 5:57 PM
>>
>> From: Long Li <longli@microsoft.com>
>>
>> Starting with Hyper-V PCI protocol version 1.3, the host VSP can send
>> PCI_BUS_RELATIONS2 and pass the vNUMA node information for devices
>on the bus.
>> The vNUMA node tells which guest NUMA node this device is on based on
>> guest VM configuration topology and physical device inforamtion.
>>
>> The patch adds code to negotiate v1.3 and process PCI_BUS_RELATIONS2.
>>
>> Signed-off-by: Long Li <longli@microsoft.com>
>> ---
>>  drivers/pci/controller/pci-hyperv.c | 107
>> ++++++++++++++++++++++++++++
>>  1 file changed, 107 insertions(+)
>>
>
>[snip]
>
>> +/*
>> + * Set NUMA node for the devices on the bus  */ static void
>> +pci_assign_numa_node(struct hv_pcibus_device *hbus) {
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
>> +
>
>get_pcichild_wslot() gets a reference to the hv_dev, so a call to put_pcic=
hild()
>is needed to balance.

Thanks for pointing this out! I will send v2 to fix this.

>
>But more broadly, is the call to set_dev_node() operating on the correct s=
truct
>device?  There's a struct device in the struct hv_device, and also one in =
the
>struct pci_dev.  Everything in this module seems to be operating on the
>former.
>For example, all the dev_err() calls identify the struct device in struct
>hv_device.
>And enumerating all the devices on a virtual PCI bus is done by iterating
>through the hbus->children list, not the bus->devices list.  I don't compl=
etely
>understand the interplay between the two struct device entries, but the
>difference makes me wonder if the above code should be setting the NUMA
>node on the struct device that's in struct hv_device.

There are two "bus" variables in this function. "bus" is a "struct pci_bus"=
 from the PCI layer. "hbus" is a "struct hv_pcibus_device" defined in pci-h=
yperv.

The parameter passed to set_dev_node is &dev->dev, the dev is enumerated fr=
om bus->devices. So dev (struct pci_dev) is from the PCI layer, this functi=
on sets the node on the device that will be used to probe and load its corr=
esponding driver.

There is a separate list of hbus->children. It's represents pci-hyperv's vi=
ew of devices on its bus. pci-hyperv presents those devices to PCI layer wh=
en pci_scan_child_bus() is called.

Long
