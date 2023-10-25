Return-Path: <linux-hyperv+bounces-584-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123F97D78C7
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 01:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70ECDB21382
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Oct 2023 23:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A97B381CD;
	Wed, 25 Oct 2023 23:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yuNRk8Mj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3100381B7
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 23:40:40 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F8618B
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 16:40:38 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9cb4de3bf0so233126276.0
        for <linux-hyperv@vger.kernel.org>; Wed, 25 Oct 2023 16:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698277238; x=1698882038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2yHYpXdKX/Z1PdTHNHNNkO8SEsjgfSsadT9YDZgRP0=;
        b=yuNRk8MjDZbUgkyEXvhp8IFsMSFPdDawqVt/qjaG/V4774b1i51mkRGMoUqRRrreD0
         Wn+wVCtzu84N5sZW9tr8mfcGdk3049NBuU8VHVJLGXDBKqOUg3iS42iP3Kq7Vm/oSmct
         mfvD+aeKe04dW8ZPm8PJgNdlP2ki5nO3p4rIyN5FSHckl5ZIkmx2xzemwtpttcXw2m3w
         Tg9ejQ5LhGlwOwO96Rcv4Yx4O9DWf/C+wlCuKoLGeTDcmAYZy8oTj8zU7LSfIFxw4PDI
         U/WNvPGVS9HH0wzO8BbeIxix0Tv8aeRRM056khxKjJOZlcO1zq3Lg7r/OWpVF5MEkUQW
         38lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698277238; x=1698882038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2yHYpXdKX/Z1PdTHNHNNkO8SEsjgfSsadT9YDZgRP0=;
        b=DWca8T6ZHN/DgxQkOa4hEwcQFeJvDis09RCLbIrlg4+AFWvaKmg4keE72nEaJBUFmI
         u4BLQEb3UEZJ+1njn6b1HPh4Hq9qiDnHhcWB3oLWqh3+2o8o1Jx2QXqnnW1j5zwW1n63
         ieCl6dwGewU9M0NzoExwa9i2Wt+ISlg+CoqJhQqH0BNpdMCFLLoV6K0uj7kKLe1UZ3S4
         pMGVKt8ODoxXpKS4AU6/rV19jHBKx96zUEtyv4ILE+43G4FEUDMRaX2tYuh5j9JvojWH
         jBmwGT8Nda+zP6J6kSQktpt4yYaiWmL/Ooqlyenmyw60+0lbywDkrPrkwvajFKWZZB/9
         DHZw==
X-Gm-Message-State: AOJu0YweAmlj6mDTBKcurq/x+gnpF9K/74t2ev1jdRBcF6DCsOqeBOrg
	ZDHCI7Kl8MV8pSoxkrygw5sOJd+8YH0IubTrUg==
X-Google-Smtp-Source: AGHT+IEPHaIkN8H3iGQWkKfJ5NpCYcT3yYMmFh0PPi0IcMzsA3hF9JA14tymNgt30lyJsEwk/WiGn6lEwEr2E4Dzgg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:bccc:0:b0:d9a:c218:8177 with SMTP
 id l12-20020a25bccc000000b00d9ac2188177mr365329ybm.8.1698277238101; Wed, 25
 Oct 2023 16:40:38 -0700 (PDT)
Date: Wed, 25 Oct 2023 23:40:34 +0000
In-Reply-To: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698277232; l=1707;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=n1veWIcKxGb7fuzlMSTmPKoEQaWG96C9Cgb9YzocQ5U=; b=W+dlkHRgIJMungJ97d0DNn75PwsHcGQp6OJdyQzjetsUzkUF+C5MUA4sHBdGuuzJqLmwBu8XE
 4b6P70t8H6LCSr0S2uDYGUmJBTSTiZLZFgaH2y2gkECIo+QpVCuuHfV
X-Mailer: b4 0.12.3
Message-ID: <20231025-ethtool_puts_impl-v1-3-6a53a93d3b72@google.com>
Subject: [PATCH 3/3] checkpatch: add ethtool_sprintf rules
From: Justin Stitt <justinstitt@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shay Agroskin <shayagr@amazon.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, 
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>, 
	Sudarsana Kalluru <skalluru@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Dimitris Michailidis <dmichail@fungible.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, 
	Salil Mehta <salil.mehta@huawei.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Louis Peens <louis.peens@corigine.com>, 
	Shannon Nelson <shannon.nelson@amd.com>, Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ronak Doshi <doshir@vmware.com>, 
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org, 
	oss-drivers@corigine.com, linux-hyperv@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

Add some warnings for using ethtool_sprintf() where a simple
ethtool_puts() would suffice.

The two cases are:

1) Use ethtool_sprintf() with just two arguments:
|       ethtool_sprintf(&data, driver[i].name);
or
2) Use ethtool_sprintf() with a standalone "%s" fmt string:
|       ethtool_sprintf(&data, "%s", driver[i].name);

The former may cause -Wformat-security warnings while the latter is just
not preferred. Both are safely in the category of warnings, not errors.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 scripts/checkpatch.pl | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7d16f863edf1..1ba9ce778746 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7020,6 +7020,19 @@ sub process {
 			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
 		}
 
+# ethtool_sprintf uses that should likely be ethtool_puts
+		if (   $line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/   ) {
+			WARN("ETHTOOL_SPRINTF",
+			     "Prefer ethtool_puts over ethtool_sprintf with only two arguments" . $herecurr);
+		}
+
+		# use $rawline because $line loses %s via sanitization and thus we can't match against it.
+		if (   $rawline =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*\"\%s\"\s*,\s*$FuncArg\s*\)/   ) {
+			WARN("ETHTOOL_SPRINTF2",
+			     "Prefer ethtool_puts over ethtool_sprintf with standalone \"%s\" specifier" . $herecurr);
+		}
+
+
 # typecasts on min/max could be min_t/max_t
 		if ($perl_version_ok &&
 		    defined $stat &&

-- 
2.42.0.758.gaed0368e0e-goog


