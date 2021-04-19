Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE297364A6B
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Apr 2021 21:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241592AbhDSTUl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Apr 2021 15:20:41 -0400
Received: from mail-co1nam11on2043.outbound.protection.outlook.com ([40.107.220.43]:29153
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241576AbhDSTUj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Apr 2021 15:20:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5+lsChP8yhkSjhasvokymzzF0oEBwBt8/zPbxbdn5xHeo5A2pUgYOcIDq9afYVfaYufzwxPFYDjJVBOM5x5HqhPK6w/IC8HeXvy+dEoJTmJ55U2EWPDA3RiqY9JpIjCVlAmlm6V7U6x+U67mx9xehQiRQU9I2wST4fAaChFStulCPJaXKxkyuHwmX7ZHtuN5N+clAZ0iaFG/mMtjeB7AZDasG//1RP3CKGdcUWFVvCvbp53rxt943YgyngqhkLRVYs+oDhlkku8YQnCRD+q7wZSuh6spctfw7fulGBnZ9+ZGpeOJ2SCsosP1SlyCfDXq3o8xbejIQHmrneWI9xl7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISmqrdj1URDv+uQeVPT8kvwRML6vBgNKgBToVY52o3o=;
 b=nyGJJSTsQED6MZ2g3KzqEHvJ1QND8IVC2w8G8ZozrZh8h4R2RoGZr9ibuPRG02LZ+f0KOjs8qm4t3leI+9BKqFKimshq7vY4wI92d4SSebE1XCqls/LHFmi26wfBr75CDKHu+4YU9mXOmVTHxcPRYFrnpqqir7O+S6QiioeD/uerX4EmbUO0hrnB7+/RL2LA9qcLrwPk1ilpfdYT3s2q+UZXcMjzEiULrtmpfWI38y5jB7j935xP3P3GZwe7RViiF46/77UeZeRZ+mpUkAoTmV67XU7oBM7vWX9o3kINRbnQ9zVCIQZNU070T4UJAw/mqsglIjDxfhHfrDFmFGNlAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=microsoft.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISmqrdj1URDv+uQeVPT8kvwRML6vBgNKgBToVY52o3o=;
 b=CtdJ+QWZvwHYScZMLzgt0hosDY6BWxBee980DKfBZT0ExlkV86of2wVie87rc8gTQuD6nZBEPmz6/48prNqG/ci4265IY5At5BAdtp8jOZbG73yCAs7dohPCTg03+C5V0oBJygrcCSs2MQfxhrowQVd7Ww/BQ2bbd37PCQRcPEL/7UAlyFwmqZTo8BL1pxIOnnwHaU+UBYlnnOpcXtwIiBSOhGO0FVWouSbAgdXHN63zCZXo06SQWuxf1hbWCpP8PsPenxuHToosgHubXAXdcD5kIBl33bsnthr/WNs0hLqwVE5uwHKQbCycwHiWS0MawWqKOZzhEjR4bjv3OkOXwA==
Received: from MWHPR13CA0009.namprd13.prod.outlook.com (2603:10b6:300:16::19)
 by MWHPR12MB1408.namprd12.prod.outlook.com (2603:10b6:300:12::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 19:20:03 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::77) by MWHPR13CA0009.outlook.office365.com
 (2603:10b6:300:16::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend
 Transport; Mon, 19 Apr 2021 19:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 19:20:03 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr
 2021 19:19:57 +0000
Subject: Re: [PATCH v3 01/14] PCI: tegra: Convert to MSI domains
To:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Frank Wunderlich <frank-w@public-files.de>,
        Thierry Reding <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-hyperv@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <kernel-team@android.com>
References: <20210330151145.997953-1-maz@kernel.org>
 <20210330151145.997953-2-maz@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <316e8be4-fa70-75e8-8483-ae38036306e0@nvidia.com>
Date:   Mon, 19 Apr 2021 20:19:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210330151145.997953-2-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afbbfe3d-5971-4f2a-b109-08d903682205
X-MS-TrafficTypeDiagnostic: MWHPR12MB1408:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR12MB1408AC4A25A0E3219E06A516D9499@MWHPR12MB1408.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fa0zNif5H6T2ITVud9jwHXdnIcO3hgXEeE96McLTVm6+eZz5eB7wAxXFzfxB6XMhdpnoORq6ZBTwXI4fH0ph99Gf3iaMCikpk2ssvSXOH8DUL1GFHNiObvInVd2FgVJzz5bBLU9eGCmP0nPhO24XJsNJNNetcA+AbKsRfV9Hpp6qwf+YlPEwheg8V6RFMN9mrVfeaZifG1OY7DK+XapUkdUhnBD0WwmiHANof4mtpaZyKDgjHy6r1l3iBzjAVwg9LGWvdfgsykItvhhRTTv/kFu8ncn89Oioe6KNJ4gUlGZ2K23PKU3udfr7kqHfn90/PZP2s6patel0vl2DQJwnI4PHgn/YTt4G7sKeQB0Q1qkSFJDA8Ih1yY4WJck8f44PYYG1mL+uhVoxVnRVl7yRkG/n0IcoxP1grZM26Gwgcv2iFgVXPO+TEPT+rsba5e5ne12uRKM3aKqUcUkEbrNLPkdz4QoDTXL7rbjiFKghSBYiw76RKjk8Fed+yeqprfqGbX1iMdkAzZynCoGbRlmn/jti2rvQL1pDx5T01ZxtVsjKgFa7DCSOrGWu0Yts282VG6huzGNGPV0vCxG5r4RUwf+kRtzpRR4jUwx+5w4cNdxaFUkqvgLclSxUvNZgN6YAL6SSbl8kJmDDdzsYWcpl6hmo/m7yRVWByEtbXByFvANpjtUzG5QCZ08bS8TzHSs3
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966006)(36840700001)(53546011)(36860700001)(478600001)(36906005)(82310400003)(316002)(86362001)(16576012)(31696002)(336012)(16526019)(47076005)(426003)(110136005)(36756003)(186003)(5660300002)(7636003)(2616005)(70206006)(31686004)(70586007)(356005)(82740400003)(4326008)(2906002)(26005)(8936002)(54906003)(83380400001)(8676002)(7416002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 19:20:03.0886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afbbfe3d-5971-4f2a-b109-08d903682205
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1408
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Marc,

On 30/03/2021 16:11, Marc Zyngier wrote:
> In anticipation of the removal of the msi_controller structure, convert
> the Tegra host controller driver to MSI domains.
> 
> We end-up with the usual two domain structure, the top one being a
> generic PCI/MSI domain, the bottom one being Tegra-specific and handling
> the actual HW interrupt allocation.
> 
> While at it, convert the normal interrupt handler to a chained handler,
> handle the controller's MSI IRQ edge triggered, support multiple MSIs
> per device and use the AFI_MSI_EN_VEC* registers to provide MSI masking.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> [treding@nvidia.com: fix, clean up and address TODOs from Marc's draft]
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>


This change is breaking a suspend test that we are running on Tegra124
Jetson-TK1. The Tegra124 Jetson TK1 uses a PCI based ethernet device ...

$ lspci
00:02.0 PCI bridge: NVIDIA Corporation TegraK1 PCIe x1 Bridge (rev a1)
01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)

After resuming from suspend, networking is no longer working. The reason
why this breaks our suspend test is because that setup is using NFS for
the rootfs. I am looking into it, but if anyone has any thoughts please
let me know.

Jon

-- 
nvpublic
