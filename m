Return-Path: <linux-hyperv+bounces-8075-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 850E9CDB012
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 01:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFD4130C8D68
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 00:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5057285CB3;
	Wed, 24 Dec 2025 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhgWFr08"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACBF26E719
	for <linux-hyperv@vger.kernel.org>; Wed, 24 Dec 2025 00:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536150; cv=none; b=tUbn6YHgGvD4mo6NTqeOmSHbLhw+S0ZnobRTnB2rHvaCpVJdfU4nn0tzFpalhnCegB1nej4e2XtJK+J+vgDDAKVlGGttBJ4b2HJM7XP0gboltbN0JV96BzC0Avumph2CNNPnf7ANAbB1ASukwC3VHCkPwBqiYOAQwCeRrdyHxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536150; c=relaxed/simple;
	bh=P4erHizl27nbkGk13UaQgtaMcmfPrCQL8OW5nr9GtQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mV2uzEhpw1kiy9ZOTVf0hYETLTlhjczHocFs6NKeoxIMW/x7o1ZYHraH9kOEObMPfMKOJ2qkCKvnj32RmC8pzuniuprE3X8fqH9DBiDkdXhB1Tv/UPwN5gbmIzOqN2MucmrtJilyXwjH9WbBe1LtZPtbsujTJTSriatUzfof9MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhgWFr08; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo6287562b3a.2
        for <linux-hyperv@vger.kernel.org>; Tue, 23 Dec 2025 16:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536145; x=1767140945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=dhgWFr08MCIgXvO+gifjtNO0TYYNX6DbBmamwC8C85tyREKMzR1iL8d+VPOIb+EUWW
         X7eV2K/Jm4KBGdxT80Rjpaa33zOqAZ85w9RZMtmbok5/sUYPEuyzOQiPh/D8phn3TBhc
         ex/qhdLdsQbofksFkEYCCAuHC9UiuvfsaJD43qqavKAdQ8P+Qiww2OLVMFSQu+Nj+LEK
         G/E3+RfWr8N+OezmWLmBPdk1xs+Ae8sKY9qKZ7fxLxNH/L4FQ5cJ8VJLcObmmo5JoXlz
         EfAf9rIhrVc+g8wVcdxJuMHrHyU5qqNw1g1i2girPLHP50Pu/w7Faj+yTuE2EWV6+qYZ
         6RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536145; x=1767140945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnWUXZAQs2u/RX1G1g/cLNdC4zcJTVF/JpiRxAH0cLc=;
        b=JOWDFSkma6LlZ+PhrVOG8gH/p46QPO6gv446UaxpbC+eimSC1WUKs7buM0f3SWXkOh
         +qpPKTphjJ6nrmjaMex97GO20b/RoVCW/IX993vKDwR31McnG/NpXv3Y2vad6rgPBlRB
         nTnJ6J7F5OXXsLLC5O+DJGXMbavfG2svSIOIPVbD/O9Y3p86iOviBlxtI8jBBACJmH3d
         RFmEW9Ssbw2agGV3s/2t1McrKJVIZ8bbIvESQGtus/fOcR5Z+In7dpdEnMPelHGRd4X4
         3wJe5MxsIXmfQ2QzAh+gcT+k01ngvF/HYudfZG9+rc7TiO3LfNwz9WcS4woOa5TM1DFf
         e1Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVLjC6SsYa1eXkyvPZQiVZ1xUqMZRPlx0TXtSLtzHZYfYz4ysfoaky5pbfJEq39X7BB1qbmOfg3ILnpbxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt0p+VsYyIMU6G21bswelKOf6NjHpSRCCl85LyupOA/R7Pa3Ip
	2V2er4b2xm82+mIyIM/Ga3amIUFnh+7lwbq+N98omP/Krn76Hl33eRTjOsMfTQ==
X-Gm-Gg: AY/fxX69lW+zBK8XvyBEPwehpLO3+1Er6T/wExDg4farIuz2jCoHrIOYL97cEwXPTZ0
	fEE3uaBkQYWRSSL3qxen4ew1kGVX5LiagBONuLBw84TrtQyLn/1Lcoc7qBN9ehnLzWYucZRsNuh
	Av8YOt7qnXiEBoH95kT47KZQ2tiSharBOy9/j6UhPlUrbckfpISPsWpQeBgQ2EmYoeOwviOX4p5
	hnyBcqKj6CeGT/7mGvulPIzO/WLmD4AyDuSCMPGR89cBDueS4khsQyyVlKw+KYF4lgWiNjAXq8C
	dZNcoCVzl1Mxosd5SdcO75jM2YJPmxapOsxh/pKDZpPqpKxo/86QKCvtXX7lHfNgA/THY87iYxK
	Qd1RBQtw3X5ovktSvypByym/Dx0wrSzbvdcDYGAWsAp155AOftWSkjMgMbIZZ4lPglOALDe7sOS
	ZBxIFugKoe+VEnAEOMDik=
X-Google-Smtp-Source: AGHT+IG9bM40+23m7ksLXlbMaHJ4J5fajkInG27QTdkeyL6rIcjmRvm7kMrKaaEMk9caXe/lgKe2eQ==
X-Received: by 2002:a05:6a00:6ca2:b0:7a9:c738:5e88 with SMTP id d2e1a72fcca58-7ff657a1298mr13744515b3a.8.1766536145181;
        Tue, 23 Dec 2025 16:29:05 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b423d86sm14802196b3a.26.2025.12.23.16.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:04 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:43 -0800
Subject: [PATCH RFC net-next v13 09/13] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-9-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Replace /proc/net parsing with ss(8) for detecting listening sockets in
wait_for_listener() functions and add support for TCP, VSOCK, and Unix
socket protocols.

The previous implementation parsed /proc/net/tcp using awk to detect
listening sockets, but this approach could not support vsock because
vsock does not export socket information to /proc/net/.

Instead, use ss so that we can detect listeners on tcp, vsock, and unix.

The protocol parameter is now required for all wait_for_listener family
functions (wait_for_listener, vm_wait_for_listener,
host_wait_for_listener) to explicitly specify which socket type to wait
for.

ss is added to the dependency check in check_deps().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 47 +++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4b5929ffc9eb..0e681d4c3a15 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -182,7 +182,7 @@ check_args() {
 }
 
 check_deps() {
-	for dep in vng ${QEMU} busybox pkill ssh; do
+	for dep in vng ${QEMU} busybox pkill ssh ss; do
 		if [[ ! -x $(command -v "${dep}") ]]; then
 			echo -e "skip:    dependency ${dep} not found!\n"
 			exit "${KSFT_SKIP}"
@@ -337,21 +337,32 @@ wait_for_listener()
 	local port=$1
 	local interval=$2
 	local max_intervals=$3
-	local protocol=tcp
-	local pattern
+	local protocol=$4
 	local i
 
-	pattern=":$(printf "%04X" "${port}") "
-
-	# for tcp protocol additionally check the socket state
-	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
-
 	for i in $(seq "${max_intervals}"); do
-		if awk -v pattern="${pattern}" \
-			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
-			/proc/net/"${protocol}"*; then
+		case "${protocol}" in
+		tcp)
+			if ss --listening --tcp --numeric | grep -q ":${port} "; then
+				break
+			fi
+			;;
+		vsock)
+			if ss --listening --vsock --numeric | grep -q ":${port} "; then
+				break
+			fi
+			;;
+		unix)
+			# For unix sockets, port is actually the socket path
+			if ss --listening --unix | grep -q "${port}"; then
+				break
+			fi
+			;;
+		*)
+			echo "Unknown protocol: ${protocol}" >&2
 			break
-		fi
+			;;
+		esac
 		sleep "${interval}"
 	done
 }
@@ -359,23 +370,25 @@ wait_for_listener()
 vm_wait_for_listener() {
 	local ns=$1
 	local port=$2
+	local protocol=$3
 
 	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
-wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
 EOF
 }
 
 host_wait_for_listener() {
 	local ns=$1
 	local port=$2
+	local protocol=$3
 
 	if [[ "${ns}" == "init_ns" ]]; then
-		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}" "${protocol}"
 	else
 		ip netns exec "${ns}" bash <<-EOF
 			$(declare -f wait_for_listener)
-			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
 		EOF
 	fi
 }
@@ -422,7 +435,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${ns}" "${port}"
+		vm_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail
@@ -463,7 +476,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${ns}" "${port}"
+		host_wait_for_listener "${ns}" "${port}" "tcp"
 		rc=$?
 	fi
 	set +o pipefail

-- 
2.47.3


