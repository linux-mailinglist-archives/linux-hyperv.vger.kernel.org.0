Return-Path: <linux-hyperv+bounces-599-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F37F77D86C7
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 18:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C8F1C20EA2
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4AF2EAE9;
	Thu, 26 Oct 2023 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B5381D4;
	Thu, 26 Oct 2023 16:33:38 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E3618A;
	Thu, 26 Oct 2023 09:33:34 -0700 (PDT)
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id A028EA065D;
	Thu, 26 Oct 2023 16:33:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id 7FCD820027;
	Thu, 26 Oct 2023 16:33:18 +0000 (UTC)
Message-ID: <39ca00132597c0cc4aac4ea11ab4b571f3981bcb.camel@perches.com>
Subject: Re: [PATCH 0/3] ethtool: Add ethtool_puts()
From: Joe Perches <joe@perches.com>
To: Kees Cook <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski
 <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan
 <ndagan@amazon.com>, Saeed Bishara <saeedb@amazon.com>, Rasesh Mody
 <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Dimitris Michailidis <dmichail@fungible.com>,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens
 <louis.peens@corigine.com>, Shannon Nelson <shannon.nelson@amd.com>, Brett
 Creeley <brett.creeley@amd.com>,  drivers@pensando.io, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Ronak Doshi
 <doshir@vmware.com>, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Nick Desaulniers
 <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
 intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com, 
 linux-hyperv@vger.kernel.org
Date: Thu, 26 Oct 2023 09:33:17 -0700
In-Reply-To: <202310260845.B2AEF3166@keescook>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
	 <202310260845.B2AEF3166@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7FCD820027
X-Stat-Signature: tqniyx7p8h5qknujg3j3u4qts1mgo166
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/hksoPTvSQ2Kfedoq7k65vXFokjR3nhCQ=
X-HE-Tag: 1698337998-357523
X-HE-Meta: U2FsdGVkX18tpZrV5M0cIIkad47JxCnUsTubWpTDvlz0rDFA4VIUVlt+9iPs+s6sPZboOUWNkNF2YmsA4OkKjT+9cbp7aW7dfS5OtgSN/mMN5BDzwU8BOhFrcfosKZsvOUTeWHFvBm8FKG4aydB9Xl/XBML0OMl1II5OdbUSCWJBCO6LTrdMZQYQFpqTPqaQPbk09KY2VZ9gAgnGjT2Ssln3kO5Lnod88TWO/LPIrlWFHGwYy5iFBijw4WT//bLtYoRJgzkvsp5BGdnQGuy/fsxv/x4UTld1ApYiCNndRdi1FcAi7wo9jKVhlZsLxYcB

On Thu, 2023-10-26 at 08:47 -0700, Kees Cook wrote:
> On Wed, Oct 25, 2023 at 11:40:31PM +0000, Justin Stitt wrote:
> > @replace_2_args@
> > identifier BUF;
> > expression VAR;
> > @@
> >=20
> > -       ethtool_sprintf
> > +       ethtool_puts
> >         (&BUF, VAR)
>=20
> I think cocci will do a better job at line folding if we adjust this
> rule like I had to adjust the next rule: completely remove and re-add
> the arguments:
>=20
> -       ethtool_sprintf(&BUF, VAR)
> +       ethtool_puts(&BUF, VAR)
>=20
> Then I think the handful of weird line wraps in the treewide patch will
> go away.
>=20

Perhaps this, but i believe spatch needs
	 --max-width=3D80
to fill all 80 columns

$ cat ethtool_puts.cocci
@@
expression a, b;
@@

-	ethtool_sprintf(a, b)
+	ethtool_puts(a, b)

@@
expression a, b;
@@

-	ethtool_sprintf(a, "%s", b)
+	ethtool_puts(a, b)

$ spatch -sp-file ethtool_puts.cocci --in-place --max-width=3D80 drivers/ne=
t
$ git diff --stat -p drivers/net
 drivers/net/dsa/lantiq_gswip.c                     |  2 +-
 drivers/net/dsa/mt7530.c                           |  2 +-
 drivers/net/dsa/qca/qca8k-common.c                 |  2 +-
 drivers/net/dsa/realtek/rtl8365mb.c                |  2 +-
 drivers/net/dsa/realtek/rtl8366-core.c             |  2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c             |  8 +--
 drivers/net/ethernet/amazon/ena/ena_ethtool.c      |  4 +-
 drivers/net/ethernet/brocade/bna/bnad_ethtool.c    |  2 +-
 drivers/net/ethernet/freescale/fec_main.c          |  4 +-
 .../net/ethernet/fungible/funeth/funeth_ethtool.c  |  8 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   | 65 +++++++++++-------=
----
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  6 +-
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c     |  3 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |  9 +--
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c     |  2 +-
 drivers/net/ethernet/intel/igb/igb_ethtool.c       |  6 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c       |  6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |  5 +-
 .../net/ethernet/microchip/sparx5/sparx5_ethtool.c |  2 +-
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   | 44 +++++++--------
 drivers/net/ethernet/pensando/ionic/ionic_stats.c  |  4 +-
 drivers/net/ethernet/wangxun/libwx/wx_ethtool.c    |  2 +-
 drivers/net/hyperv/netvsc_drv.c                    |  4 +-
 drivers/net/phy/nxp-tja11xx.c                      |  2 +-
 drivers/net/phy/smsc.c                             |  2 +-
 drivers/net/vmxnet3/vmxnet3_ethtool.c              | 10 ++--
 28 files changed, 100 insertions(+), 112 deletions(-)

diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.=
c
index 1a2d5797bf98c..ff67bbf5a789b 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1759,7 +1759,7 @@ static void gswip_get_strings(struct dsa_switch *ds, =
int port, u32 stringset,
 		return;
=20
 	for (i =3D 0; i < ARRAY_SIZE(gswip_rmon_cnt); i++)
-		ethtool_sprintf(&data, "%s", gswip_rmon_cnt[i].name);
+		ethtool_puts(&data, gswip_rmon_cnt[i].name);
 }
=20
 static u32 gswip_bcm_ram_entry_read(struct gswip_priv *priv, u32 table,
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index ecf5d3deb36eb..3c2cce442facf 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -836,7 +836,7 @@ mt7530_get_strings(struct dsa_switch *ds, int port, u32=
 stringset,
 		return;
=20
 	for (i =3D 0; i < ARRAY_SIZE(mt7530_mib); i++)
-		ethtool_sprintf(&data, "%s", mt7530_mib[i].name);
+		ethtool_puts(&data, mt7530_mib[i].name);
 }
=20
 static void
diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k=
-common.c
index 9ff0a3c1cb91d..94a949e27445f 100644
--- a/drivers/net/dsa/qca/qca8k-common.c
+++ b/drivers/net/dsa/qca/qca8k-common.c
@@ -487,7 +487,7 @@ void qca8k_get_strings(struct dsa_switch *ds, int port,=
 u32 stringset,
 		return;
=20
 	for (i =3D 0; i < priv->info->mib_count; i++)
-		ethtool_sprintf(&data, "%s", ar8327_mib[i].name);
+		ethtool_puts(&data, ar8327_mib[i].name);
 }
=20
 void qca8k_get_ethtool_stats(struct dsa_switch *ds, int port,
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/=
rtl8365mb.c
index d171c18dd354c..ba0bafaca9aa9 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1303,7 +1303,7 @@ static void rtl8365mb_get_strings(struct dsa_switch *=
ds, int port, u32 stringset
=20
 	for (i =3D 0; i < RTL8365MB_MIB_END; i++) {
 		struct rtl8365mb_mib_counter *mib =3D &rtl8365mb_mib_counters[i];
-		ethtool_sprintf(&data, "%s", mib->name);
+		ethtool_puts(&data, mib->name);
 	}
 }
=20
diff --git a/drivers/net/dsa/realtek/rtl8366-core.c b/drivers/net/dsa/realt=
ek/rtl8366-core.c
index 82e267b8fddb1..59f98d2c8769b 100644
--- a/drivers/net/dsa/realtek/rtl8366-core.c
+++ b/drivers/net/dsa/realtek/rtl8366-core.c
@@ -401,7 +401,7 @@ void rtl8366_get_strings(struct dsa_switch *ds, int por=
t, u32 stringset,
 		return;
=20
 	for (i =3D 0; i < priv->num_mib_counters; i++)
-		ethtool_sprintf(&data, "%s", priv->mib_counters[i].name);
+		ethtool_puts(&data, priv->mib_counters[i].name);
 }
 EXPORT_SYMBOL_GPL(rtl8366_get_strings);
=20
diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vites=
se-vsc73xx-core.c
index e6f29e4e508c1..dd50502e21229 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -949,7 +949,7 @@ static void vsc73xx_get_strings(struct dsa_switch *ds, =
int port, u32 stringset,
 	indices[5] =3D ((val >> 26) & 0x1f); /* TX counter 2 */
=20
 	/* The first counters is the RX octets */
-	ethtool_sprintf(&buf, "RxEtherStatsOctets");
+	ethtool_puts(&buf, "RxEtherStatsOctets");
=20
 	/* Each port supports recording 3 RX counters and 3 TX counters,
 	 * figure out what counters we use in this set-up and return the
@@ -959,15 +959,15 @@ static void vsc73xx_get_strings(struct dsa_switch *ds=
, int port, u32 stringset,
 	 */
 	for (i =3D 0; i < 3; i++) {
 		cnt =3D vsc73xx_find_counter(vsc, indices[i], false);
-		ethtool_sprintf(&buf, "%s", cnt ? cnt->name : "");
+		ethtool_puts(&buf, cnt ? cnt->name : "");
 	}
=20
 	/* TX stats begins with the number of TX octets */
-	ethtool_sprintf(&buf, "TxEtherStatsOctets");
+	ethtool_puts(&buf, "TxEtherStatsOctets");
=20
 	for (i =3D 3; i < 6; i++) {
 		cnt =3D vsc73xx_find_counter(vsc, indices[i], true);
-		ethtool_sprintf(&buf, "%s", cnt ? cnt->name : "");
+		ethtool_puts(&buf, cnt ? cnt->name : "");
=20
 	}
 }
diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/et=
hernet/amazon/ena/ena_ethtool.c
index d671df4b76bc7..e3ef081aa42bc 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -299,13 +299,13 @@ static void ena_get_strings(struct ena_adapter *adapt=
er,
=20
 	for (i =3D 0; i < ENA_STATS_ARRAY_GLOBAL; i++) {
 		ena_stats =3D &ena_stats_global_strings[i];
-		ethtool_sprintf(&data, ena_stats->name);
+		ethtool_puts(&data, ena_stats->name);
 	}
=20
 	if (eni_stats_needed) {
 		for (i =3D 0; i < ENA_STATS_ARRAY_ENI(adapter); i++) {
 			ena_stats =3D &ena_stats_eni_strings[i];
-			ethtool_sprintf(&data, ena_stats->name);
+			ethtool_puts(&data, ena_stats->name);
 		}
 	}
=20
diff --git a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c b/drivers/net/=
ethernet/brocade/bna/bnad_ethtool.c
index df10edff5603a..d1ad6c9f81404 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
@@ -608,7 +608,7 @@ bnad_get_strings(struct net_device *netdev, u32 strings=
et, u8 *string)
=20
 	for (i =3D 0; i < BNAD_ETHTOOL_STATS_NUM; i++) {
 		BUG_ON(!(strlen(bnad_net_stats_strings[i]) < ETH_GSTRING_LEN));
-		ethtool_sprintf(&string, bnad_net_stats_strings[i]);
+		ethtool_puts(&string, bnad_net_stats_strings[i]);
 	}
=20
 	bmap =3D bna_tx_rid_mask(&bnad->bna);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethern=
et/freescale/fec_main.c
index 032c15b541ff2..b53554225945f 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2864,10 +2864,10 @@ static void fec_enet_get_strings(struct net_device =
*netdev,
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i =3D 0; i < ARRAY_SIZE(fec_stats); i++) {
-			ethtool_sprintf(&data, "%s", fec_stats[i].name);
+			ethtool_puts(&data, fec_stats[i].name);
 		}
 		for (i =3D 0; i < ARRAY_SIZE(fec_xdp_stat_strs); i++) {
-			ethtool_sprintf(&data, "%s", fec_xdp_stat_strs[i]);
+			ethtool_puts(&data, fec_xdp_stat_strs[i]);
 		}
 		page_pool_ethtool_stats_get_strings(data);
=20
diff --git a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c b/driver=
s/net/ethernet/fungible/funeth/funeth_ethtool.c
index 31aa185f4d17b..091c93bd75872 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_ethtool.c
@@ -655,7 +655,7 @@ static void fun_get_strings(struct net_device *netdev, =
u32 sset, u8 *data)
 						i);
 		}
 		for (j =3D 0; j < ARRAY_SIZE(txq_stat_names); j++)
-			ethtool_sprintf(&p, txq_stat_names[j]);
+			ethtool_puts(&p, txq_stat_names[j]);
=20
 		for (i =3D 0; i < fp->num_xdpqs; i++) {
 			for (j =3D 0; j < ARRAY_SIZE(xdpq_stat_names); j++)
@@ -663,7 +663,7 @@ static void fun_get_strings(struct net_device *netdev, =
u32 sset, u8 *data)
 						xdpq_stat_names[j], i);
 		}
 		for (j =3D 0; j < ARRAY_SIZE(xdpq_stat_names); j++)
-			ethtool_sprintf(&p, xdpq_stat_names[j]);
+			ethtool_puts(&p, xdpq_stat_names[j]);
=20
 		for (i =3D 0; i < netdev->real_num_rx_queues; i++) {
 			for (j =3D 0; j < ARRAY_SIZE(rxq_stat_names); j++)
@@ -671,10 +671,10 @@ static void fun_get_strings(struct net_device *netdev=
, u32 sset, u8 *data)
 						i);
 		}
 		for (j =3D 0; j < ARRAY_SIZE(rxq_stat_names); j++)
-			ethtool_sprintf(&p, rxq_stat_names[j]);
+			ethtool_puts(&p, rxq_stat_names[j]);
=20
 		for (j =3D 0; j < ARRAY_SIZE(tls_stat_names); j++)
-			ethtool_sprintf(&p, tls_stat_names[j]);
+			ethtool_puts(&p, tls_stat_names[j]);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c b/drivers/n=
et/ethernet/hisilicon/hns/hns_dsaf_gmac.c
index 8f391e2adcc0b..bdb7afaabdd06 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -678,7 +678,7 @@ static void hns_gmac_get_strings(u32 stringset, u8 *dat=
a)
 		return;
=20
 	for (i =3D 0; i < ARRAY_SIZE(g_gmac_stats_string); i++)
-		ethtool_sprintf(&buff, g_gmac_stats_string[i].desc);
+		ethtool_puts(&buff, g_gmac_stats_string[i].desc);
 }
=20
 static int hns_gmac_get_sset_count(int stringset)
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c b/drivers/=
net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
index fc26ffaae6202..c58833eb48306 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
@@ -752,7 +752,7 @@ static void hns_xgmac_get_strings(u32 stringset, u8 *da=
ta)
 		return;
=20
 	for (i =3D 0; i < ARRAY_SIZE(g_xgmac_stats_string); i++)
-		ethtool_sprintf(&buff, g_xgmac_stats_string[i].desc);
+		ethtool_puts(&buff, g_xgmac_stats_string[i].desc);
 }
=20
 /**
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net=
/ethernet/hisilicon/hns/hns_ethtool.c
index b54f3706fb974..fe40cceb0f794 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -912,42 +912,41 @@ static void hns_get_strings(struct net_device *netdev=
, u32 stringset, u8 *data)
=20
 	if (stringset =3D=3D ETH_SS_TEST) {
 		if (priv->ae_handle->phy_if !=3D PHY_INTERFACE_MODE_XGMII)
-			ethtool_sprintf(&buff,
-					hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
-		ethtool_sprintf(&buff,
-				hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
+			ethtool_puts(&buff,
+				     hns_nic_test_strs[MAC_INTERNALLOOP_MAC]);
+		ethtool_puts(&buff, hns_nic_test_strs[MAC_INTERNALLOOP_SERDES]);
 		if ((netdev->phydev) && (!netdev->phydev->is_c45))
-			ethtool_sprintf(&buff,
-					hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
+			ethtool_puts(&buff,
+				     hns_nic_test_strs[MAC_INTERNALLOOP_PHY]);
=20
 	} else {
-		ethtool_sprintf(&buff, "rx_packets");
-		ethtool_sprintf(&buff, "tx_packets");
-		ethtool_sprintf(&buff, "rx_bytes");
-		ethtool_sprintf(&buff, "tx_bytes");
-		ethtool_sprintf(&buff, "rx_errors");
-		ethtool_sprintf(&buff, "tx_errors");
-		ethtool_sprintf(&buff, "rx_dropped");
-		ethtool_sprintf(&buff, "tx_dropped");
-		ethtool_sprintf(&buff, "multicast");
-		ethtool_sprintf(&buff, "collisions");
-		ethtool_sprintf(&buff, "rx_over_errors");
-		ethtool_sprintf(&buff, "rx_crc_errors");
-		ethtool_sprintf(&buff, "rx_frame_errors");
-		ethtool_sprintf(&buff, "rx_fifo_errors");
-		ethtool_sprintf(&buff, "rx_missed_errors");
-		ethtool_sprintf(&buff, "tx_aborted_errors");
-		ethtool_sprintf(&buff, "tx_carrier_errors");
-		ethtool_sprintf(&buff, "tx_fifo_errors");
-		ethtool_sprintf(&buff, "tx_heartbeat_errors");
-		ethtool_sprintf(&buff, "rx_length_errors");
-		ethtool_sprintf(&buff, "tx_window_errors");
-		ethtool_sprintf(&buff, "rx_compressed");
-		ethtool_sprintf(&buff, "tx_compressed");
-		ethtool_sprintf(&buff, "netdev_rx_dropped");
-		ethtool_sprintf(&buff, "netdev_tx_dropped");
-
-		ethtool_sprintf(&buff, "netdev_tx_timeout");
+		ethtool_puts(&buff, "rx_packets");
+		ethtool_puts(&buff, "tx_packets");
+		ethtool_puts(&buff, "rx_bytes");
+		ethtool_puts(&buff, "tx_bytes");
+		ethtool_puts(&buff, "rx_errors");
+		ethtool_puts(&buff, "tx_errors");
+		ethtool_puts(&buff, "rx_dropped");
+		ethtool_puts(&buff, "tx_dropped");
+		ethtool_puts(&buff, "multicast");
+		ethtool_puts(&buff, "collisions");
+		ethtool_puts(&buff, "rx_over_errors");
+		ethtool_puts(&buff, "rx_crc_errors");
+		ethtool_puts(&buff, "rx_frame_errors");
+		ethtool_puts(&buff, "rx_fifo_errors");
+		ethtool_puts(&buff, "rx_missed_errors");
+		ethtool_puts(&buff, "tx_aborted_errors");
+		ethtool_puts(&buff, "tx_carrier_errors");
+		ethtool_puts(&buff, "tx_fifo_errors");
+		ethtool_puts(&buff, "tx_heartbeat_errors");
+		ethtool_puts(&buff, "rx_length_errors");
+		ethtool_puts(&buff, "tx_window_errors");
+		ethtool_puts(&buff, "rx_compressed");
+		ethtool_puts(&buff, "tx_compressed");
+		ethtool_puts(&buff, "netdev_rx_dropped");
+		ethtool_puts(&buff, "netdev_tx_dropped");
+
+		ethtool_puts(&buff, "netdev_tx_timeout");
=20
 		h->dev->ops->get_strings(h, stringset, buff);
 	}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/e=
thernet/intel/i40e/i40e_ethtool.c
index fd7163128c4da..79c3e7968a857 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2514,13 +2514,11 @@ static void i40e_get_priv_flag_strings(struct net_d=
evice *netdev, u8 *data)
 	u8 *p =3D data;
=20
 	for (i =3D 0; i < I40E_PRIV_FLAGS_STR_LEN; i++)
-		ethtool_sprintf(&p, "%s",
-				i40e_gstrings_priv_flags[i].flag_string);
+		ethtool_puts(&p, i40e_gstrings_priv_flags[i].flag_string);
 	if (pf->hw.pf_id !=3D 0)
 		return;
 	for (i =3D 0; i < I40E_GL_PRIV_FLAGS_STR_LEN; i++)
-		ethtool_sprintf(&p, "%s",
-				i40e_gl_gstrings_priv_flags[i].flag_string);
+		ethtool_puts(&p, i40e_gl_gstrings_priv_flags[i].flag_string);
 }
=20
 static void i40e_get_strings(struct net_device *netdev, u32 stringset,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/e=
thernet/intel/iavf/iavf_ethtool.c
index 6f236d1a6444e..75d433dc19742 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -396,8 +396,7 @@ static void iavf_get_priv_flag_strings(struct net_devic=
e *netdev, u8 *data)
 	unsigned int i;
=20
 	for (i =3D 0; i < IAVF_PRIV_FLAGS_STR_LEN; i++)
-		ethtool_sprintf(&data, "%s",
-				iavf_gstrings_priv_flags[i].flag_string);
+		ethtool_puts(&data, iavf_gstrings_priv_flags[i].flag_string);
 }
=20
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/eth=
ernet/intel/ice/ice_ethtool.c
index 7870a39845473..e16c04924d10c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1133,8 +1133,7 @@ __ice_get_strings(struct net_device *netdev, u32 stri=
ngset, u8 *data,
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i =3D 0; i < ICE_VSI_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					ice_gstrings_vsi_stats[i].stat_string);
+			ethtool_puts(&p, ice_gstrings_vsi_stats[i].stat_string);
=20
 		if (ice_is_port_repr_netdev(netdev))
 			return;
@@ -1153,8 +1152,7 @@ __ice_get_strings(struct net_device *netdev, u32 stri=
ngset, u8 *data,
 			return;
=20
 		for (i =3D 0; i < ICE_PF_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					ice_gstrings_pf_stats[i].stat_string);
+			ethtool_puts(&p, ice_gstrings_pf_stats[i].stat_string);
=20
 		for (i =3D 0; i < ICE_MAX_USER_PRIORITY; i++) {
 			ethtool_sprintf(&p, "tx_priority_%u_xon.nic", i);
@@ -1170,8 +1168,7 @@ __ice_get_strings(struct net_device *netdev, u32 stri=
ngset, u8 *data,
 		break;
 	case ETH_SS_PRIV_FLAGS:
 		for (i =3D 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
-			ethtool_sprintf(&p, "%s",
-					ice_gstrings_priv_flags[i].name);
+			ethtool_puts(&p, ice_gstrings_priv_flags[i].name);
 		break;
 	default:
 		break;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/e=
thernet/intel/idpf/idpf_ethtool.c
index 52ea38669f85b..bf58989a573e4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -532,7 +532,7 @@ static void idpf_add_stat_strings(u8 **p, const struct =
idpf_stats *stats,
 	unsigned int i;
=20
 	for (i =3D 0; i < size; i++)
-		ethtool_sprintf(p, "%s", stats[i].stat_string);
+		ethtool_puts(p, stats[i].stat_string);
 }
=20
 /**
diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/eth=
ernet/intel/igb/igb_ethtool.c
index 9cbd35b6df43d..e0a24c7c37f9b 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2356,11 +2356,9 @@ static void igb_get_strings(struct net_device *netde=
v, u32 stringset, u8 *data)
 		break;
 	case ETH_SS_STATS:
 		for (i =3D 0; i < IGB_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					igb_gstrings_stats[i].stat_string);
+			ethtool_puts(&p, igb_gstrings_stats[i].stat_string);
 		for (i =3D 0; i < IGB_NETDEV_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					igb_gstrings_net_stats[i].stat_string);
+			ethtool_puts(&p, igb_gstrings_net_stats[i].stat_string);
 		for (i =3D 0; i < adapter->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/eth=
ernet/intel/igc/igc_ethtool.c
index bf4f611286ae3..22a09d3cd65f8 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -773,11 +773,9 @@ static void igc_ethtool_get_strings(struct net_device =
*netdev, u32 stringset,
 		break;
 	case ETH_SS_STATS:
 		for (i =3D 0; i < IGC_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					igc_gstrings_stats[i].stat_string);
+			ethtool_puts(&p, igc_gstrings_stats[i].stat_string);
 		for (i =3D 0; i < IGC_NETDEV_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					igc_gstrings_net_stats[i].stat_string);
+			ethtool_puts(&p, igc_gstrings_net_stats[i].stat_string);
 		for (i =3D 0; i < adapter->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net=
/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 4dd897806fa5a..dd722b0381e04 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1413,12 +1413,11 @@ static void ixgbe_get_strings(struct net_device *ne=
tdev, u32 stringset,
 	switch (stringset) {
 	case ETH_SS_TEST:
 		for (i =3D 0; i < IXGBE_TEST_LEN; i++)
-			ethtool_sprintf(&p, "%s", ixgbe_gstrings_test[i]);
+			ethtool_puts(&p, ixgbe_gstrings_test[i]);
 		break;
 	case ETH_SS_STATS:
 		for (i =3D 0; i < IXGBE_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p, "%s",
-					ixgbe_gstrings_stats[i].stat_string);
+			ethtool_puts(&p, ixgbe_gstrings_stats[i].stat_string);
 		for (i =3D 0; i < netdev->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c b/drive=
rs/net/ethernet/microchip/sparx5/sparx5_ethtool.c
index 37d2584b48a7c..a06dc5a9b3551 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ethtool.c
@@ -1012,7 +1012,7 @@ static void sparx5_get_sset_strings(struct net_device=
 *ndev, u32 sset, u8 *data)
 		return;
=20
 	for (idx =3D 0; idx < sparx5->num_ethtool_stats; idx++)
-		ethtool_sprintf(&data, "%s", sparx5->stats_layout[idx]);
+		ethtool_puts(&data, sparx5->stats_layout[idx]);
 }
=20
 static void sparx5_get_sset_data(struct net_device *ndev,
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers=
/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index e75cbb287625f..1636ce61a3c07 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -800,7 +800,7 @@ static void nfp_get_self_test_strings(struct net_device=
 *netdev, u8 *data)
=20
 	for (i =3D 0; i < NFP_TEST_TOTAL_NUM; i++)
 		if (nfp_self_test[i].is_supported(netdev))
-			ethtool_sprintf(&data, nfp_self_test[i].name);
+			ethtool_puts(&data, nfp_self_test[i].name);
 }
=20
 static int nfp_get_self_test_count(struct net_device *netdev)
@@ -852,24 +852,24 @@ static u8 *nfp_vnic_get_sw_stats_strings(struct net_d=
evice *netdev, u8 *data)
 		ethtool_sprintf(&data, "rvec_%u_tx_busy", i);
 	}
=20
-	ethtool_sprintf(&data, "hw_rx_csum_ok");
-	ethtool_sprintf(&data, "hw_rx_csum_inner_ok");
-	ethtool_sprintf(&data, "hw_rx_csum_complete");
-	ethtool_sprintf(&data, "hw_rx_csum_err");
-	ethtool_sprintf(&data, "rx_replace_buf_alloc_fail");
-	ethtool_sprintf(&data, "rx_tls_decrypted_packets");
-	ethtool_sprintf(&data, "hw_tx_csum");
-	ethtool_sprintf(&data, "hw_tx_inner_csum");
-	ethtool_sprintf(&data, "tx_gather");
-	ethtool_sprintf(&data, "tx_lso");
-	ethtool_sprintf(&data, "tx_tls_encrypted_packets");
-	ethtool_sprintf(&data, "tx_tls_ooo");
-	ethtool_sprintf(&data, "tx_tls_drop_no_sync_data");
-
-	ethtool_sprintf(&data, "hw_tls_no_space");
-	ethtool_sprintf(&data, "rx_tls_resync_req_ok");
-	ethtool_sprintf(&data, "rx_tls_resync_req_ign");
-	ethtool_sprintf(&data, "rx_tls_resync_sent");
+	ethtool_puts(&data, "hw_rx_csum_ok");
+	ethtool_puts(&data, "hw_rx_csum_inner_ok");
+	ethtool_puts(&data, "hw_rx_csum_complete");
+	ethtool_puts(&data, "hw_rx_csum_err");
+	ethtool_puts(&data, "rx_replace_buf_alloc_fail");
+	ethtool_puts(&data, "rx_tls_decrypted_packets");
+	ethtool_puts(&data, "hw_tx_csum");
+	ethtool_puts(&data, "hw_tx_inner_csum");
+	ethtool_puts(&data, "tx_gather");
+	ethtool_puts(&data, "tx_lso");
+	ethtool_puts(&data, "tx_tls_encrypted_packets");
+	ethtool_puts(&data, "tx_tls_ooo");
+	ethtool_puts(&data, "tx_tls_drop_no_sync_data");
+
+	ethtool_puts(&data, "hw_tls_no_space");
+	ethtool_puts(&data, "rx_tls_resync_req_ok");
+	ethtool_puts(&data, "rx_tls_resync_req_ign");
+	ethtool_puts(&data, "rx_tls_resync_sent");
=20
 	return data;
 }
@@ -943,13 +943,13 @@ nfp_vnic_get_hw_stats_strings(u8 *data, unsigned int =
num_vecs, bool repr)
 	swap_off =3D repr * NN_ET_SWITCH_STATS_LEN;
=20
 	for (i =3D 0; i < NN_ET_SWITCH_STATS_LEN; i++)
-		ethtool_sprintf(&data, nfp_net_et_stats[i + swap_off].name);
+		ethtool_puts(&data, nfp_net_et_stats[i + swap_off].name);
=20
 	for (i =3D NN_ET_SWITCH_STATS_LEN; i < NN_ET_SWITCH_STATS_LEN * 2; i++)
-		ethtool_sprintf(&data, nfp_net_et_stats[i - swap_off].name);
+		ethtool_puts(&data, nfp_net_et_stats[i - swap_off].name);
=20
 	for (i =3D NN_ET_SWITCH_STATS_LEN * 2; i < NN_ET_GLOBAL_STATS_LEN; i++)
-		ethtool_sprintf(&data, nfp_net_et_stats[i].name);
+		ethtool_puts(&data, nfp_net_et_stats[i].name);
=20
 	for (i =3D 0; i < num_vecs; i++) {
 		ethtool_sprintf(&data, "rxq_%u_pkts", i);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_stats.c b/drivers/ne=
t/ethernet/pensando/ionic/ionic_stats.c
index 9859a44329851..1f6022fb76797 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_stats.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_stats.c
@@ -258,10 +258,10 @@ static void ionic_sw_stats_get_strings(struct ionic_l=
if *lif, u8 **buf)
 	int i, q_num;
=20
 	for (i =3D 0; i < IONIC_NUM_LIF_STATS; i++)
-		ethtool_sprintf(buf, ionic_lif_stats_desc[i].name);
+		ethtool_puts(buf, ionic_lif_stats_desc[i].name);
=20
 	for (i =3D 0; i < IONIC_NUM_PORT_STATS; i++)
-		ethtool_sprintf(buf, ionic_port_stats_desc[i].name);
+		ethtool_puts(buf, ionic_port_stats_desc[i].name);
=20
 	for (q_num =3D 0; q_num < MAX_Q(lif); q_num++)
 		ionic_sw_stats_get_tx_strings(lif, buf, q_num);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c b/drivers/net/=
ethernet/wangxun/libwx/wx_ethtool.c
index ddc5f6d20b9c8..6e9e5f01c1525 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_ethtool.c
@@ -75,7 +75,7 @@ void wx_get_strings(struct net_device *netdev, u32 string=
set, u8 *data)
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i =3D 0; i < WX_GLOBAL_STATS_LEN; i++)
-			ethtool_sprintf(&p, wx_gstrings_stats[i].stat_string);
+			ethtool_puts(&p, wx_gstrings_stats[i].stat_string);
 		for (i =3D 0; i < netdev->num_tx_queues; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
 			ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_dr=
v.c
index 3ba3c8fb28a5d..cbd9405fc2f38 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -1582,10 +1582,10 @@ static void netvsc_get_strings(struct net_device *d=
ev, u32 stringset, u8 *data)
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i =3D 0; i < ARRAY_SIZE(netvsc_stats); i++)
-			ethtool_sprintf(&p, netvsc_stats[i].name);
+			ethtool_puts(&p, netvsc_stats[i].name);
=20
 		for (i =3D 0; i < ARRAY_SIZE(vf_stats); i++)
-			ethtool_sprintf(&p, vf_stats[i].name);
+			ethtool_puts(&p, vf_stats[i].name);
=20
 		for (i =3D 0; i < nvdev->num_chn; i++) {
 			ethtool_sprintf(&p, "tx_queue_%u_packets", i);
diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index a713999651421..2c263ae44b4f3 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -415,7 +415,7 @@ static void tja11xx_get_strings(struct phy_device *phyd=
ev, u8 *data)
 	int i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
-		ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].string);
+		ethtool_puts(&data, tja11xx_hw_stats[i].string);
 }
=20
 static void tja11xx_get_stats(struct phy_device *phydev,
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 1c7306a1af131..150aea7c9c367 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -508,7 +508,7 @@ static void smsc_get_strings(struct phy_device *phydev,=
 u8 *data)
 	int i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(smsc_hw_stats); i++)
-		ethtool_sprintf(&data, "%s", smsc_hw_stats[i].string);
+		ethtool_puts(&data, smsc_hw_stats[i].string);
 }
=20
 static u64 smsc_get_stat(struct phy_device *phydev, int i)
diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vm=
xnet3_ethtool.c
index 98c22d7d87a2a..8f5f202cde39b 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -245,20 +245,20 @@ vmxnet3_get_strings(struct net_device *netdev, u32 st=
ringset, u8 *buf)
=20
 	for (j =3D 0; j < adapter->num_tx_queues; j++) {
 		for (i =3D 0; i < ARRAY_SIZE(vmxnet3_tq_dev_stats); i++)
-			ethtool_sprintf(&buf, vmxnet3_tq_dev_stats[i].desc);
+			ethtool_puts(&buf, vmxnet3_tq_dev_stats[i].desc);
 		for (i =3D 0; i < ARRAY_SIZE(vmxnet3_tq_driver_stats); i++)
-			ethtool_sprintf(&buf, vmxnet3_tq_driver_stats[i].desc);
+			ethtool_puts(&buf, vmxnet3_tq_driver_stats[i].desc);
 	}
=20
 	for (j =3D 0; j < adapter->num_rx_queues; j++) {
 		for (i =3D 0; i < ARRAY_SIZE(vmxnet3_rq_dev_stats); i++)
-			ethtool_sprintf(&buf, vmxnet3_rq_dev_stats[i].desc);
+			ethtool_puts(&buf, vmxnet3_rq_dev_stats[i].desc);
 		for (i =3D 0; i < ARRAY_SIZE(vmxnet3_rq_driver_stats); i++)
-			ethtool_sprintf(&buf, vmxnet3_rq_driver_stats[i].desc);
+			ethtool_puts(&buf, vmxnet3_rq_driver_stats[i].desc);
 	}
=20
 	for (i =3D 0; i < ARRAY_SIZE(vmxnet3_global_stats); i++)
-		ethtool_sprintf(&buf, vmxnet3_global_stats[i].desc);
+		ethtool_puts(&buf, vmxnet3_global_stats[i].desc);
 }
=20
 netdev_features_t vmxnet3_fix_features(struct net_device *netdev,


