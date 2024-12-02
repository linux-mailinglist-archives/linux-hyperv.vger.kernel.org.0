Return-Path: <linux-hyperv+bounces-3385-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161979E025B
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Dec 2024 13:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5CFC161646
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Dec 2024 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7091FECA2;
	Mon,  2 Dec 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="XGa4ceBG";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="yhmHVrRV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D551FE469;
	Mon,  2 Dec 2024 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733143462; cv=pass; b=L0xDj2crFREwJUJN2yPEXKl/vgslKfNIiVyF9OZ2BM6R9JJXyGd38P/gH6YSu7osAZlPxiTowNeI37XSFdHGkY93uYb/alCc3Ufmd0QpysKsUYGINeF+h9LKhZ1R/QG4YQWnW2e1sxEGYOGxvS3MbIxsJ5vVu5qW8UnnHKTPS3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733143462; c=relaxed/simple;
	bh=hqMvhVoV6pTnNIwNDDid8c0CMEInYZ8cVKpjy83HMQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XXx9yWGzNFyv5KCCd9qZMwDcKHHV6yIPKRjBNVKSu1pCZS4nZBieI4uV82LeQJTVKWr/48eLCBG76pZTGel2WshQ69iGSjxM63eYI85T/ChtiE5j4Mg6X7bF/cIZSnhaAvjcxFsQl166oJfgA4Z1FxgtsI2bqsvgQH5daNXgT5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de; spf=pass smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=XGa4ceBG; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=yhmHVrRV; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1733143269; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tjAtsdHVDrtIfy3qHQKrQfFPeXm4zRLBx5ycuGn6UdG/7HbWOPDz7ebzA5TjrRoKxd
    ZTWlXS29sfkNqFokkKcA6mBMyOWtp4xAw+u3+50q1wm8d4rMAVJyhz7TUBNTZDVOYZ0p
    Y3TMxHF0EOMiqvqiZkWDJpUZDYuqZKslfDEe7TIl9KiwQiybb5ghs7eoWhKY4xYcj/KY
    56hxT+iGZCeUIkd8qgXgsxNLUmMqQ1m53DF9VyHisdyao7eTnTtxZUMv21mSXuDY9PyX
    M0Bfhq/+v+Ko2RUxhzqzWfCP5S31uWHUmwx4SQ0jiCT6/uZkYKSW3cTtvNeJtnkjI0g2
    uoBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733143269;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=hqMvhVoV6pTnNIwNDDid8c0CMEInYZ8cVKpjy83HMQM=;
    b=fN5eOejOFi/+zHk6GJq/+Wjq/jkNSHxDxPTYPIGOanocGeMneEMbXF++DbBV3BHanU
    AH4stPaOq6CHZzLTpHy/Z+KeXTAE7CRCX79ZvWNLqnsD9r4Zk13tYVlXMHjc0ReC1f6T
    0bv8eFSY/QYXvys7MXBkN7vGu5F3+f8yTMBL9XNcntZOI5gJqehwulTqlQ/trougayYG
    vSus9NCb4CyIIR093nzpYHMT0R0urFWnIC/cHl/yJ1UQTc2tVI9NwkaKOCdV+TDBcYsg
    e32Y3tlCmFP/mU6kCT4XYllsBd6PKWYMESD9pFI57Hm0+yqD2HbLR2UBBcEbzCanlnYP
    g/Og==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733143269;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=hqMvhVoV6pTnNIwNDDid8c0CMEInYZ8cVKpjy83HMQM=;
    b=XGa4ceBGVPE+anc9GEx5xCSs24D6ddN8lJbxGNsyAK/JsLLzf+yx1DBK/aRhRjnk21
    Sgp4BhtWNCmaAXOJfkcNom9ClaNnXpobl1GsGi+kV3LC2MwsVOQNAHaOVRRVce3fI4HV
    yVNgTOAJdmlRzvuQFwjpiCr2Zi117d6z8XQ77ja6GNGGDUl8nxOsEQloat4Pl/vZiVub
    pm+lnjNbe5KRbL9wKtBW03U1J9/0JNgqz7RojVPrd5KzpeGhnj+XpEZdUF6VGLPMxRQg
    SH1RIQyfIVwducQ5KK8nQQrvM156PMrYMQTdL90W85MkNymjefcd+CW728TjENgUUGPb
    IoOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733143269;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=hqMvhVoV6pTnNIwNDDid8c0CMEInYZ8cVKpjy83HMQM=;
    b=yhmHVrRVYgvxampNUjW1NyuThtSJT9dwf3erK9mPTSmXqcksJb68FZPq55rB5t25nq
    ylBApWdr17s9ELxoE2Cg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0uv8ZofWaSUMjanMCZmxMwm2OGJkumVDfIDOsNMxne61spO"
Received: from sender
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Dd65250B2Cf9pXH
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 2 Dec 2024 13:41:09 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v1] tools/hv: add a .gitignore file
Date: Mon,  2 Dec 2024 13:40:52 +0100
Message-ID: <20241202124107.28650-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Remove generated files from 'git status' output after 'make -C tools/hv'.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 tools/hv/.gitignore | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/hv/.gitignore

diff --git a/tools/hv/.gitignore b/tools/hv/.gitignore
new file mode 100644
index 000000000000..0c5bc15d602f
--- /dev/null
+++ b/tools/hv/.gitignore
@@ -0,0 +1,3 @@
+hv_fcopy_uio_daemon
+hv_kvp_daemon
+hv_vss_daemon

