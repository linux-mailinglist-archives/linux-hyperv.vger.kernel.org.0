Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5CE364AEC
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Apr 2021 22:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhDSUCw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Apr 2021 16:02:52 -0400
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:63609
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230160AbhDSUCu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Apr 2021 16:02:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eouOPOWzdzkUdhzkH+bhj7zSZ5hLB/lBiolaNy3CGejW5/V6OJf6y1rpqPC9tctuY1TbJiN38PEy1X/kN6Ax3A7XSUi8GutgDFoDJkEIODyGQOt2WDdr+Wkm19XJUUpgv3JpYi6lAECh2B8Oan9qBADXRtFoXqjT8sHNfNuphOfr8ftGa4WIYJ6ZM748I65Muu4bjBqdyd9jQtDFsNhOleMMxHVboHYhak9JdvCWKjHHWG/YMnF/VPUQ9EYqtD/0FYl8MNC0JwZU4ibIu9Lv21Yuq48pPdNuvozMgZpAtxbFwQy2qNF8ZPQD/Y21hzqrg8Rc+45IANJC3E1B4TJbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZxixqWTpQaPs0Lj1AKbNapjdDfZ0XnAoJoNovPaEp0=;
 b=eTWYXflxn/dd/pqNPaGoknZa+Bvz3xLRQa2OXFXGetsFa98yp8LM4nmV/oJWYpdldZlG4eNeYWd7hn/5xXrsjSz91x5FLIz0pVbGPJUpT377Af1mv+mzlSZ+hv25RN/dbNbSm3kyrJAnmnYyoPbrpWAzUmaq97MV4wb0gnWGTDZw9YB1wAgv9tJv6lgU1gMN1u9kQS9wuV5LzL+R0PD3L2UaVfsUh0YvwbWaCXmmFr2c5DDEQHk9LFx82H0222DEva9cgda4YXFm0yCVVCw4+Q3gpsGipAKpd5cSZpDN9wOPuK9MPVt9RCS3rmcqjg09T4nweUy2xoc5WGhs2vrIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=microsoft.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZxixqWTpQaPs0Lj1AKbNapjdDfZ0XnAoJoNovPaEp0=;
 b=tUtRfJoYrhROAOwsFyQz921U9ONkcQbL4euxkrWl6F+icDUI3l2KC+zJ7aL2E7dFTzvGxAhpikOQGDsVWS6YNyWgHMEuNJRZOuH8GHfwjMrNprluRCimNwKWUjeOD8ieBnXZ5BYdk0HHe5565wh78XRmEVpDEYi/BHfldcwSdGngDNSt3mgSIcA9toa9+dKye4sLpOM3C31BJ1dtudKTrq7g4xuZnGoHYtVr8w6VJ2oFZLj9B0L1NGsj7fIt5MYfo2Y28QdbPhR/oRPvMqeQlTKjZW6BQEbAc0HOCJMpu1wBQVitRB0zZgXssoHP42XYZKCEY0cwWIB6EyOJVujRqg==
Received: from DM5PR10CA0005.namprd10.prod.outlook.com (2603:10b6:4:2::15) by
 DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Mon, 19 Apr 2021 20:02:18 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::48) by DM5PR10CA0005.outlook.office365.com
 (2603:10b6:4:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 20:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 20:02:18 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr
 2021 20:02:12 +0000
Subject: Re: [PATCH v3 01/14] PCI: tegra: Convert to MSI domains
From:   Jon Hunter <jonathanh@nvidia.com>
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
 <316e8be4-fa70-75e8-8483-ae38036306e0@nvidia.com>
Message-ID: <638a9996-c762-fa11-b740-6a41d4a83bcc@nvidia.com>
Date:   Mon, 19 Apr 2021 21:02:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <316e8be4-fa70-75e8-8483-ae38036306e0@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87d0fd90-ac65-4902-6297-08d9036e0905
X-MS-TrafficTypeDiagnostic: DM5PR12MB1708:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR12MB17084ACA557592A28154DDC7D9499@DM5PR12MB1708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vo0eKVRbjFKAoXFuij8V8wmravDh1VQ/aNBzFg1JwUJCGbYHrU/84X3ie35meZBpLW5WIyu2T0aoG8EjllCkL9bgAPdrQFRX/kG0ULmI8FuPU+1HkHBAr8qnGu/BlKpUYmKVopKMumhyxivONrBir5DcXExqxBfy1QMx+FdhN1o/cgcGpZHC+/TZWpyHX/AUkAEoGOSjXLxP8DlZwdAiRvLwR6Rdib7qzKL75FmOzrisq1VpUYqL/rgfTR2nMyjfqoKFZ4HhSa/5gZ1J0xiFIAo1U7dgFy7bwHdlp23SQwp3ZPSdXpeVIBc8Hwvy+kmJOus5rYP/4w7+2zWIFrk6nLRJp+FxGYyvnn5cl1yudsccPc6CVpPattBGFuNWcC4PC4AMb9ab4HHmsdsin6Y+dlaS/k4EFpcdy6R+067Lr2t7B2tcjqy0kSeB+U7fRmPsAHxPySDcpkyVDrFmTQlbiywYVLTaeS+F1aRvhgNtTh41epQopI0LmliKEP0Q6u/qnLA8JYBfPJSnJ0rw9hwRkkQGqC4Hpi/dRjUXjw56kItsl9YENe8YWVqUU2qO8Fo9RLbbjgcD3Ex8kHqeWg0sB2YmMIRoPnw8BO087cKFnvpP4su0mB49D6GpfEeL2Td91I9reFRuF4Rkx9gdEXZqg2aKM/+KBm9QdEMG6jUy4HYceIJQN1OmTsVcqlCmOolJ
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(36756003)(82310400003)(5660300002)(26005)(110136005)(36906005)(47076005)(16576012)(316002)(86362001)(31696002)(2906002)(36860700001)(8676002)(186003)(83380400001)(4326008)(16526019)(356005)(2616005)(54906003)(31686004)(70586007)(7416002)(7636003)(478600001)(8936002)(336012)(53546011)(82740400003)(426003)(70206006)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 20:02:18.1140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d0fd90-ac65-4902-6297-08d9036e0905
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 19/04/2021 20:19, Jon Hunter wrote:
> Hi Marc,
> 
> On 30/03/2021 16:11, Marc Zyngier wrote:
>> In anticipation of the removal of the msi_controller structure, convert
>> the Tegra host controller driver to MSI domains.
>>
>> We end-up with the usual two domain structure, the top one being a
>> generic PCI/MSI domain, the bottom one being Tegra-specific and handling
>> the actual HW interrupt allocation.
>>
>> While at it, convert the normal interrupt handler to a chained handler,
>> handle the controller's MSI IRQ edge triggered, support multiple MSIs
>> per device and use the AFI_MSI_EN_VEC* registers to provide MSI masking.
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> [treding@nvidia.com: fix, clean up and address TODOs from Marc's draft]
>> Signed-off-by: Thierry Reding <treding@nvidia.com>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
> 
> 
> This change is breaking a suspend test that we are running on Tegra124
> Jetson-TK1. The Tegra124 Jetson TK1 uses a PCI based ethernet device ...
> 
> $ lspci
> 00:02.0 PCI bridge: NVIDIA Corporation TegraK1 PCIe x1 Bridge (rev a1)
> 01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
> 
> After resuming from suspend, networking is no longer working. The reason
> why this breaks our suspend test is because that setup is using NFS for
> the rootfs. I am looking into it, but if anyone has any thoughts please
> let me know.


So the following does appear to fix it ...

diff --git a/drivers/pci/controller/pci-tegra.c
b/drivers/pci/controller/pci-tegra.c
index eaba7b2fab4a..558f02e0693d 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1802,13 +1802,17 @@ static void tegra_pcie_enable_msi(struct
tegra_pcie *pcie)
 {
        const struct tegra_pcie_soc *soc = pcie->soc;
        struct tegra_msi *msi = &pcie->msi;
-       u32 reg;
+       u32 i, reg;

        afi_writel(pcie, msi->phys >> soc->msi_base_shift,
AFI_MSI_FPCI_BAR_ST);
        afi_writel(pcie, msi->phys, AFI_MSI_AXI_BAR_ST);
        /* this register is in 4K increments */
        afi_writel(pcie, 1, AFI_MSI_BAR_SZ);

+       /* enable all MSI vectors */
+       for (i = 0; i < 8; i++)
+               afi_writel(pcie, 0xffffffff, AFI_MSI_EN_VEC(i));
+
        /* and unmask the MSI interrupt */
        reg = afi_readl(pcie, AFI_INTR_MASK);
        reg |= AFI_INTR_MASK_MSI_MASK;
@@ -1837,13 +1841,17 @@ static void tegra_pcie_msi_teardown(struct
tegra_pcie *pcie)

 static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
 {
-       u32 value;
+       u32 i, value;

        /* mask the MSI interrupt */
        value = afi_readl(pcie, AFI_INTR_MASK);
        value &= ~AFI_INTR_MASK_MSI_MASK;
        afi_writel(pcie, value, AFI_INTR_MASK);

+       /* disable all MSI vectors */
+       for (i = 0; i < 8; i++)
+               afi_writel(pcie, 0, AFI_MSI_EN_VEC(i));
+
        return 0;
 }


Any reason why that code was removed?

Thanks
Jon

-- 
nvpublic
