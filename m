Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00416F11E
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Feb 2020 22:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgBYV2s (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Feb 2020 16:28:48 -0500
Received: from mail-dm6nam12on2092.outbound.protection.outlook.com ([40.107.243.92]:14944
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbgBYV2s (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Feb 2020 16:28:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDyrQa17WmKGtHacQ62zKrfQUdI31MUgwv9ux68X6vOsHb+LHd9PSq7q8a9LehSWjOARIMA0k0OqZYiSDMXCr61nQSaa+Z84UnNj0s1n7IkZxdONlqSORVa78AKpsGvtHoKVlVaxxk6A9SZ21tas/DXT+MxAIbELSkbkYcH7u52cdkuEy3ZfuXcr/eqm4QsVr//qglk3x6bchnf3ruDlLGBJv2JttP0cppOQbPJURCmAFpmzXj9p8abQkPbffJQe7p2fToe/xJmiLq6rxjk9yqtEkx3LmdfXs1lP6NrdxMr5oYnzXwUbsvhIOLSnLey7MhaXOLjJcnins2wOgr4yCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI4/s9YSobMykp84uLAUEhI+Na9MWWUOBPBEq1FFksk=;
 b=mWTBQo8hz4Bl11D0i8K8EGOcxZQj0o+DxeVu8uxc3ggQDDFaZ3YymzfTPImy1UeHyoDtq2hTha0qgR9KvrB99k97pWxhDiVu11rdnxeelHavdQjTftDduG010ybhV/9FmPhabBsdxN9lnqJfhifvbqpb9qcZPFv5lPp/MjYya3Y0lpAJ2Eg3EkXiAgUOrvBgXwtnaXPzdzKhZepXR74J8MzPJ9mENc6OH4z3Ts6eQh9XJj8IQsTJur+U+ix5UBHHo3QcH9yaYc0UERPE0xeplXZsjqu+yziSKHz8Cd1Z0V63jHmBBh8OPA5Ia+vLksKKSEBVbU84snfrodqTnkM8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI4/s9YSobMykp84uLAUEhI+Na9MWWUOBPBEq1FFksk=;
 b=fHY6pkgoNRyPBCL+7yHihTXaRL/O/LwM9b7+esW+UIHcqRyToB68PGhbHwvA8KQzpTrSLDlLAuba70UTpd1ujSU2PbpkDYXqajeMt+sKgeGGKn3FOQS75ZedjxG31TWVoJIvYmAqYllYfy1+4UJdHP/QZr15gcw3xwdfyZBHLD8=
Received: from BN8PR21MB1155.namprd21.prod.outlook.com (2603:10b6:408:73::10)
 by BN8PR21MB1155.namprd21.prod.outlook.com (2603:10b6:408:73::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.3; Tue, 25 Feb
 2020 21:28:44 +0000
Received: from BN8PR21MB1155.namprd21.prod.outlook.com
 ([fe80::9123:f430:1749:be38]) by BN8PR21MB1155.namprd21.prod.outlook.com
 ([fe80::9123:f430:1749:be38%9]) with mapi id 15.20.2793.003; Tue, 25 Feb 2020
 21:28:44 +0000
From:   Long Li <longli@microsoft.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [Patch v4 2/2] PCI: hv: Add support for protocol 1.3 and support
 PCI_BUS_RELATIONS2
Thread-Topic: [Patch v4 2/2] PCI: hv: Add support for protocol 1.3 and support
 PCI_BUS_RELATIONS2
Thread-Index: AQHVyk097vUi/S1nuEyAmTGUqCQ7Gqgr+iuAgAC1vvA=
Date:   Tue, 25 Feb 2020 21:28:43 +0000
Message-ID: <BN8PR21MB11551FFDB5C6350BC420288ACEED0@BN8PR21MB1155.namprd21.prod.outlook.com>
References: <1578946101-74036-1-git-send-email-longli@linuxonhyperv.com>
 <1578946101-74036-2-git-send-email-longli@linuxonhyperv.com>
 <20200225103607.GB4029@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200225103607.GB4029@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:eddf:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 88c95fe2-abb6-4a84-5824-08d7ba39b108
x-ms-traffictypediagnostic: BN8PR21MB1155:|BN8PR21MB1155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR21MB11555F6BFD2613195E881591CEED0@BN8PR21MB1155.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(33656002)(9686003)(6506007)(76116006)(186003)(316002)(8936002)(4326008)(81156014)(8676002)(81166006)(2906002)(64756008)(66446008)(71200400001)(55016002)(478600001)(86362001)(8990500004)(7696005)(110136005)(66476007)(66556008)(66946007)(52536014)(10290500003)(54906003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1155;H:BN8PR21MB1155.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3aiElYpO0YiXibO5lsDCkayO/MaWdft5DMLAAQN4PW6O3eyVcUqRDsJZmzxPEtYRPamByyCcA2ww+hetu4nnEFuYniTTpL74ZeOvqEEM28QJec73DeySUw5qHTRhKCToxboHpxaueg90hVaBhrgcEqF7EBvg5J3X6eQ0WXQ7fD1qJadJBpQxQutjc+vLtbPDZUyZ8jSoTeWadZLLpuVDEn1/EZfekxBhMG05nTjimeIhk/sNNk8giU1UkDxT8JGBIDY9v7StLBv50G8AHZ6VqjKL18+UoeXkvOc/Pujy+Ogk+mz+iSJanj0p06rE096xmSoYCy7T2nOpRuR+gTOPxCp/vutguTezr3E5VLy6d5KFiU1u5ks2Brsy1D+t53UI6Iyuk1bCMVdURBDjUUVGZxiFtc+1b6yo9GIUwkk2mbqqjhLTFzYhD1U17WA5CNCR
x-ms-exchange-antispam-messagedata: kHA4xs/nh2kKOTX03AKDYg2dnHyudl5TInM49SLJRkiUArilA+CDyWGwAsHRRWvnnnijpc9jicXONthIg1IIs1VldWXhaSUwhdlRe1Ljzwt9VY8jQvL7BPL/ebCAdxYsK3MctQFY1vgDYX3kVEoQx58EYzefAHlgXpijJ+O1SNX4r0LrzJFJNIImlQ1svw1HDaF5dGQO7LOX5MUhl3AZiQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c95fe2-abb6-4a84-5824-08d7ba39b108
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 21:28:43.8163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cA5G9o70NH7CeRB6EICf5tkurAjB6szAX4mh5A7sw6yHr/VE9L1sL6e0EjHOzUAnkLdzdU7iZgHaPaBQN+E1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1155
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

>Subject: Re: [Patch v4 2/2] PCI: hv: Add support for protocol 1.3 and supp=
ort
>PCI_BUS_RELATIONS2
>
>On Mon, Jan 13, 2020 at 12:08:21PM -0800, longli@linuxonhyperv.com wrote:
>> From: Long Li <longli@microsoft.com>
>>
>> Starting with Hyper-V PCI protocol version 1.3, the host VSP can send
>> PCI_BUS_RELATIONS2 and pass the vNUMA node information for devices
>on
>> the bus. The vNUMA node tells which guest NUMA node this device is on
>> based on guest VM configuration topology and physical device inforamtion=
.
>
>s/inforamtion/information
>
>Please rebase this series on top of my pci/hv branch, it does not apply, I=
 will
>merge it then.
>
>Thanks,
>Lorenzo

I will send v5.

Thanks,
Long

>
>> Add code to negotiate v1.3 and process PCI_BUS_RELATIONS2.
>>
>> Signed-off-by: Long Li <longli@microsoft.com>
>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>> ---
>> Changes
>> v2: Changed some spaces to tabs, added put_pcichild() after
>> get_pcichild_wslot(), renamed pci_assign_numa_node() to
>> hv_pci_assign_numa_node()
>> v4: Fixed spelling
>>
>>  drivers/pci/controller/pci-hyperv.c | 109
>> ++++++++++++++++++++++++++++
>>  1 file changed, 109 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c
>> b/drivers/pci/controller/pci-hyperv.c
>> index 3b3e1967cf08..147358fae8a2 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -63,6 +63,7 @@
>>  enum pci_protocol_version_t {
>>  	PCI_PROTOCOL_VERSION_1_1 =3D PCI_MAKE_VERSION(1, 1),	/*
>Win10 */
>>  	PCI_PROTOCOL_VERSION_1_2 =3D PCI_MAKE_VERSION(1, 2),	/* RS1
>*/
>> +	PCI_PROTOCOL_VERSION_1_3 =3D PCI_MAKE_VERSION(1, 3),	/*
>Vibranium */
>>  };
>>
>>  #define CPU_AFFINITY_ALL	-1ULL
>> @@ -72,6 +73,7 @@ enum pci_protocol_version_t {
>>   * first.
>>   */
>>  static enum pci_protocol_version_t pci_protocol_versions[] =3D {
>> +	PCI_PROTOCOL_VERSION_1_3,
>>  	PCI_PROTOCOL_VERSION_1_2,
>>  	PCI_PROTOCOL_VERSION_1_1,
>>  };
>> @@ -124,6 +126,7 @@ enum pci_message_type {
>>  	PCI_RESOURCES_ASSIGNED2		=3D PCI_MESSAGE_BASE + 0x16,
>>  	PCI_CREATE_INTERRUPT_MESSAGE2	=3D PCI_MESSAGE_BASE + 0x17,
>>  	PCI_DELETE_INTERRUPT_MESSAGE2	=3D PCI_MESSAGE_BASE + 0x18,
>/* unused */
>> +	PCI_BUS_RELATIONS2		=3D PCI_MESSAGE_BASE + 0x19,
>>  	PCI_MESSAGE_MAXIMUM
>>  };
>>
>> @@ -169,6 +172,26 @@ struct pci_function_description {
>>  	u32	ser;	/* serial number */
>>  } __packed;
>>
>> +enum pci_device_description_flags {
>> +	HV_PCI_DEVICE_FLAG_NONE			=3D 0x0,
>> +	HV_PCI_DEVICE_FLAG_NUMA_AFFINITY	=3D 0x1,
>> +};
>> +
>> +struct pci_function_description2 {
>> +	u16	v_id;	/* vendor ID */
>> +	u16	d_id;	/* device ID */
>> +	u8	rev;
>> +	u8	prog_intf;
>> +	u8	subclass;
>> +	u8	base_class;
>> +	u32	subsystem_id;
>> +	union	win_slot_encoding win_slot;
>> +	u32	ser;	/* serial number */
>> +	u32	flags;
>> +	u16	virtual_numa_node;
>> +	u16	reserved;
>> +} __packed;
>> +
>>  /**
>>   * struct hv_msi_desc
>>   * @vector:		IDT entry
>> @@ -304,6 +327,12 @@ struct pci_bus_relations {
>>  	struct pci_function_description func[0];  } __packed;
>>
>> +struct pci_bus_relations2 {
>> +	struct pci_incoming_message incoming;
>> +	u32 device_count;
>> +	struct pci_function_description2 func[0]; } __packed;
>> +
>>  struct pci_q_res_req_response {
>>  	struct vmpacket_descriptor hdr;
>>  	s32 status;			/* negative values are failures */
>> @@ -1417,6 +1446,7 @@ static void hv_compose_msi_msg(struct irq_data
>*data, struct msi_msg *msg)
>>  		break;
>>
>>  	case PCI_PROTOCOL_VERSION_1_2:
>> +	case PCI_PROTOCOL_VERSION_1_3:
>>  		size =3D hv_compose_msi_req_v2(&ctxt.int_pkts.v2,
>>  					dest,
>>  					hpdev->desc.win_slot.slot,
>> @@ -1798,6 +1828,27 @@ static void hv_pci_remove_slots(struct
>hv_pcibus_device *hbus)
>>  	}
>>  }
>>
>> +/*
>> + * Set NUMA node for the devices on the bus  */ static void
>> +hv_pci_assign_numa_node(struct hv_pcibus_device *hbus) {
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
>> +
>> +		put_pcichild(hv_dev);
>> +	}
>> +}
>> +
>>  /**
>>   * create_root_hv_pci_bus() - Expose a new root PCI bus
>>   * @hbus:	Root PCI bus, as understood by this driver
>> @@ -1820,6 +1871,7 @@ static int create_root_hv_pci_bus(struct
>> hv_pcibus_device *hbus)
>>
>>  	pci_lock_rescan_remove();
>>  	pci_scan_child_bus(hbus->pci_bus);
>> +	hv_pci_assign_numa_node(hbus);
>>  	pci_bus_assign_resources(hbus->pci_bus);
>>  	hv_pci_assign_slots(hbus);
>>  	pci_bus_add_devices(hbus->pci_bus);
>> @@ -2088,6 +2140,7 @@ static void pci_devices_present_work(struct
>work_struct *work)
>>  		 */
>>  		pci_lock_rescan_remove();
>>  		pci_scan_child_bus(hbus->pci_bus);
>> +		hv_pci_assign_numa_node(hbus);
>>  		hv_pci_assign_slots(hbus);
>>  		pci_unlock_rescan_remove();
>>  		break;
>> @@ -2184,6 +2237,46 @@ static void hv_pci_devices_present(struct
>hv_pcibus_device *hbus,
>>  		kfree(dr);
>>  }
>>
>> +/**
>> + * hv_pci_devices_present2() - Handle list of new children
>> + * @hbus:	Root PCI bus, as understood by this driver
>> + * @relations2:	Packet from host listing children
>> + *
>> + * This function is the v2 version of hv_pci_devices_present()  */
>> +static void hv_pci_devices_present2(struct hv_pcibus_device *hbus,
>> +				    struct pci_bus_relations2 *relations) {
>> +	struct hv_dr_state *dr;
>> +	int i;
>> +
>> +	dr =3D kzalloc(offsetof(struct hv_dr_state, func) +
>> +		     (sizeof(struct hv_pcidev_description) *
>> +		      (relations->device_count)), GFP_NOWAIT);
>> +
>> +	if (!dr)
>> +		return;
>> +
>> +	dr->device_count =3D relations->device_count;
>> +	for (i =3D 0; i < dr->device_count; i++) {
>> +		dr->func[i].v_id =3D relations->func[i].v_id;
>> +		dr->func[i].d_id =3D relations->func[i].d_id;
>> +		dr->func[i].rev =3D relations->func[i].rev;
>> +		dr->func[i].prog_intf =3D relations->func[i].prog_intf;
>> +		dr->func[i].subclass =3D relations->func[i].subclass;
>> +		dr->func[i].base_class =3D relations->func[i].base_class;
>> +		dr->func[i].subsystem_id =3D relations->func[i].subsystem_id;
>> +		dr->func[i].win_slot =3D relations->func[i].win_slot;
>> +		dr->func[i].ser =3D relations->func[i].ser;
>> +		dr->func[i].flags =3D relations->func[i].flags;
>> +		dr->func[i].virtual_numa_node =3D
>> +			relations->func[i].virtual_numa_node;
>> +	}
>> +
>> +	if (hv_pci_start_relations_work(hbus, dr))
>> +		kfree(dr);
>> +}
>> +
>>  /**
>>   * hv_eject_device_work() - Asynchronously handles ejection
>>   * @work:	Work struct embedded in internal device struct
>> @@ -2289,6 +2382,7 @@ static void hv_pci_onchannelcallback(void
>*context)
>>  	struct pci_response *response;
>>  	struct pci_incoming_message *new_message;
>>  	struct pci_bus_relations *bus_rel;
>> +	struct pci_bus_relations2 *bus_rel2;
>>  	struct pci_dev_inval_block *inval;
>>  	struct pci_dev_incoming *dev_message;
>>  	struct hv_pci_dev *hpdev;
>> @@ -2356,6 +2450,21 @@ static void hv_pci_onchannelcallback(void
>*context)
>>  				hv_pci_devices_present(hbus, bus_rel);
>>  				break;
>>
>> +			case PCI_BUS_RELATIONS2:
>> +
>> +				bus_rel2 =3D (struct pci_bus_relations2 *)buffer;
>> +				if (bytes_recvd <
>> +				    offsetof(struct pci_bus_relations2, func) +
>> +				    (sizeof(struct pci_function_description2) *
>> +				     (bus_rel2->device_count))) {
>> +					dev_err(&hbus->hdev->device,
>> +						"bus relations v2 too small\n");
>> +					break;
>> +				}
>> +
>> +				hv_pci_devices_present2(hbus, bus_rel2);
>> +				break;
>> +
>>  			case PCI_EJECT:
>>
>>  				dev_message =3D (struct pci_dev_incoming
>*)buffer;
>> --
>> 2.17.1
>>
