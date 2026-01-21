Return-Path: <linux-hyperv+bounces-8417-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKsqDKkacWmodQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8417-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 19:27:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D7A5B40E
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7C2B7A419A
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA893101A5;
	Wed, 21 Jan 2026 17:36:34 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4983164A1
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016994; cv=none; b=CJXanHbkS5sxQg8zEnzo5gDeAZxFzArf2E8wig1VradeyAwRCkQt4RZfp2GryeZo/flqgR36/389O9Dypj12+kSUdEonhiNQS1Cw/iCHIQKf/csA7FVj8oEcXXbRBum6apZ5D3abptRWK0eY0FaaCsMoJrKUWsWxgp0vGtaA0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016994; c=relaxed/simple;
	bh=N89ZNW3oha+wxXG+OHPJcmDoXFbropcF/evfEsV90xs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sJCPhcRC+OIrdRCm8jd91JZMNnKjYl2vG98DAaCbYhoYPyXicUEynjeIuNz1SK7WionHrsotlukZhSAM1YEL9mhnJ+XVy1EsS7QTVU75/EbDZaNEBSwru8LBVzpUa3ANN2+97Maeim3mrP25n0ih3ddEZDE+qYTs+ff+j9H22tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c5389c3d4cso7902485a.3
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 09:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769016991; x=1769621791;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE3io2YTVlpYr6JqBHdH0n+Tgy3q9xeBQJGveVd5U2M=;
        b=XzEWBv3hNhFBvgJ8aZkR+YRGrFyjhp5CIhiRwHTFhk9eLdB5Ivyg8SFTl6PiQ2vWBd
         kLbPfHfUhJQoxAEOpQfmu5GXZbWD0qmiB29ydbHOr5c/+Tb3wFtcaAlGRr7g4rjEuIoM
         jYMC+PvtCb/Ca1gHVWtUZjD0OntkN6wYpAiIEJHi1wsF3OUME5p37lLY0tYS7oZ2vRFJ
         6I4qhEnPWRv+iYgrRijENCn8Z3JvAH7gQnWajyHtsWadALTjoBewb23eQuwq8CZY9U4X
         Ei8uuoQT8rcTsxLv6OOtQzPhwkmR3KcoppAQPsW8iUcemVWeIa8fkooEZUe5QUFg1sQG
         xdUw==
X-Forwarded-Encrypted: i=1; AJvYcCVPH6IJLeUjzavrYH+AWlVYMJtPTNNTO06CFKvlyPDjwhzJF+Mx/LWEIG6xGB/m0d5IHKZwGVgI4o9ZC9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8GbajIUB2Mzh6LVR8Vn8IdAE/YVTCumXMu8/chHqsPOGqA7RE
	ni01pwdx+pPoHq3EoBW/HKi8pzBik2wwUGAIks+1ZYYLzNNf2FXLLniu4Srp+w==
X-Gm-Gg: AZuq6aIj9vInfwajjRPkU+28fhlql532kX4vvbrUjRHaRt/fAWQ/YANu9zVbHgCD565
	gmDTDaQgd76QJ+8BjYTLhTJH1WQUOHoiXdw1QBj0HQS/Qgq9psCF3d2WjXU1ErlR8zNtPXtozKG
	Em7tzJi6+h5WjSQywypRJWZfwQQkTRj9UTd/Xp8t1lc2/Sunh8dKwmvthjMkgNTHg0QXlzlriHH
	uBM6COZY7WhXWZrAObE/UupuOazA8+5nf6x9qIpuekCEWPYlEnJmcWzcGB3Jp+1v+qAVTYDmOU1
	Ij2lWz/4Y2p8OvqHrPQiFnkhtGIhoJYprAmQS/n625oqRaOE4/31MpI2/zX8IxLQ73ovFfttfxQ
	b5Qt57RD2OXiICMX/cbxXTeGNlyLCsQcAo5HSNLcFppyKTq/X7aInmnb14mAdTBETgfmok33ySv
	4l
X-Received: by 2002:a05:6830:6d2f:b0:7cf:dc2d:8508 with SMTP id 46e09a7af769-7cfded3d668mr9124127a34.1.1769010979642;
        Wed, 21 Jan 2026 07:56:19 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0e94b2sm10676020a34.7.2026.01.21.07.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 07:56:19 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/9] net: convert drivers to .get_rx_ring_count
 (last part)
Date: Wed, 21 Jan 2026 07:54:37 -0800
Message-Id: <20260121-grxring_big_v4-v1-0-07655be56bcf@debian.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL72cGkC/yXMQQrCMBAF0KuEv25gEq1iriJSbJ3GcTHKJJZA6
 d1FXT94KwqbcEFyK4wXKfJUJBc6h+l+1cxebkgOkeKBQgw+WzPRPIySh2Xv+552x/nERIHROby
 MZ2m/8Azl6pVbxeUv5T0+eKrfD9v2ARa7w8J8AAAA
X-Change-ID: 20260121-grxring_big_v4-55037f9e001e
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Igor Russkikh <irusskikh@marvell.com>, Simon Horman <horms@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
 Edward Cree <ecree.xilinx@gmail.com>, Brett Creeley <brett.creeley@amd.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
 linux-net-drivers@amd.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2946; i=leitao@debian.org;
 h=from:subject:message-id; bh=N89ZNW3oha+wxXG+OHPJcmDoXFbropcF/evfEsV90xs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpcPchSzyXwKpYKmrtStXXlYiOFQV06V6flIEsp
 V13f4iNEbSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaXD3IQAKCRA1o5Of/Hh3
 bXJ6D/9MmdJjsBDbGE5s0Wi+gUPjhQoACGhQ1fm3nWmR25mSJXYc+1q91NUYVChe7Ioijf3riCL
 LHid4f0+jK3sG+DTCeYkqdtOF06Sy9OYKWV4GDVma4Fj6RP9WHbMJ76vzY2FVIC9vVuycBcJLgK
 WajuohiDWm+VgLGgNTjknQOLKLwurgRc243N8LmC6Cvc/K8a3O0ych9LHU4A/qKUYAZckIPzZJ2
 azRwIqTp+jCSY4x/Gqgi7iaUNcrnEECUg47Suy+iyhoNIsFySTQRfeTnb6Nj/4H0gkuYgZaro9/
 HEGvXeZcjs6tBDh0HOl2xprm1bOejXb+sdCFhHa1eTqv58UmS6epqghbb/CZFXznK8TbadYPpoI
 3402GeTyqJiQ3Qw+gwUHe7DDFME2/D7KGarvIjY8dOwxGPG1jTmlISRiqYQTLpBiPekgHkCKDy0
 Fox4887rNMIkWutGmQtIVSQp8DcHJjsYO7FSxrPOS8xJ3II6rdVTwd54db+pGDfgF/46DSmxu64
 xNQvbZiIlTOczPxbiZgBZmu/khVPhIpWLbxRhz8Xay3ufdj5IvGm0r5sbVsid+3ircyjp6Q9EHp
 tlfYc/AiI76cdz61YBvVXeKeIHCNR6G9AX7pINrAUX0Ib232YzewPl0QxGA9KmYFJENo2gFZ+Oe
 yQqJD//nhBo8VFg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,microsoft.com,fb.com,meta.com,gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8417-lists,linux-hyperv=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D3D7A5B40E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns the following
drivers with the new ethtool API for querying RX ring parameters.

 * sfc
 * ionic
 * sfc/siena
 * sfc/ef100
 * fbnic
 * mana
 * nfp
 * atlantic
 * benet (this is v2 in fact, where v1 had some discussions that
   required a v2). See link [0]

Link: https://lore.kernel.org/all/20260119094514.5b12a097@kernel.org/ [0]

This is covering the last drivers, and as soon as this lands, I will
change the ethtool framework to avoid calling .get_rx_ring_count for
ETHTOOL_GRXRINGS, simplifying the ethtool core framework.

Part 1 is already merged in net-next and can be seen in
https://lore.kernel.org/all/20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org/

Part 2 is already merged in net-next except benet driver, which is now included
in here
https://lore.kernel.org/all/20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org/

PS: all of these change were compile-tested only.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (9):
      net: benet: convert to use .get_rx_ring_count
      net: atlantic: convert to use .get_rx_ring_count
      net: nfp: convert to use .get_rx_ring_count
      net: mana: convert to use .get_rx_ring_count
      net: fbnic: convert to use .get_rx_ring_count
      net: ionic: convert to use .get_rx_ring_count
      net: sfc: efx: convert to use .get_rx_ring_count
      net: sfc: siena: convert to use .get_rx_ring_count
      net: sfc: falcon: convert to use .get_rx_ring_count

 .../net/ethernet/aquantia/atlantic/aq_ethtool.c    | 15 +++++----
 drivers/net/ethernet/emulex/benet/be_ethtool.c     | 37 ++++++++--------------
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c    | 12 ++++---
 drivers/net/ethernet/microsoft/mana/mana_ethtool.c | 13 ++------
 .../net/ethernet/netronome/nfp/nfp_net_ethtool.c   | 11 +++++--
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 18 ++---------
 drivers/net/ethernet/sfc/ef100_ethtool.c           |  1 +
 drivers/net/ethernet/sfc/ethtool.c                 |  1 +
 drivers/net/ethernet/sfc/ethtool_common.c          | 11 ++++---
 drivers/net/ethernet/sfc/ethtool_common.h          |  1 +
 drivers/net/ethernet/sfc/falcon/ethtool.c          | 12 ++++---
 drivers/net/ethernet/sfc/siena/ethtool.c           |  1 +
 drivers/net/ethernet/sfc/siena/ethtool_common.c    | 11 ++++---
 drivers/net/ethernet/sfc/siena/ethtool_common.h    |  1 +
 14 files changed, 72 insertions(+), 73 deletions(-)
---
base-commit: d8f87aa5fa0a4276491fa8ef436cd22605a3f9ba
change-id: 20260121-grxring_big_v4-55037f9e001e

Best regards,
--  
Breno Leitao <leitao@debian.org>


